#!/usr/bin/env bb

(require '[babashka.process :refer [process]]
         '[babashka.fs :as fs]
         '[clojure.string :as str]
         '[clojure.java.io :as io])

;; State management with atoms
(def scroll-state (atom {:scrolling false
                         :direction nil
                         :pid nil
                         :rate 60}))
(def scroll-proc (atom nil)) ; Atom to hold the process object

(def scroll-binary "/Users/ryan/.talon/user/community/plugin/mouse/smoothscroll")
(def command-pipe "/Users/ryan/.talon/user/community/plugin/mouse/scroll-command-pipe")
(def log-file "/Users/ryan/.talon/user/community/plugin/mouse/scroll-server.log")

(defn log [& args]
  #_(spit log-file (str (java.time.LocalDateTime/now) " " (str/join " " args) "\n") :append true)
  nil)

;; Create the named pipe if it doesn't exist
(when-not (fs/exists? command-pipe)
  (log "Creating command pipe at" command-pipe)
  (process ["mkfifo" command-pipe]))

;; Initialize log file
(when-not (fs/exists? log-file)
  (fs/create-file log-file))
(log "=== Scroll server starting ===")

(defn stop-scroll []
  (log "Stopping scroll")
  ;; Prefer process object for killing
  (when-let [proc @scroll-proc]
    (try
      (babashka.process/destroy-tree proc)
      (reset! scroll-proc nil)
      (catch Exception e
        (log "Error destroying process tree:" e))))
  ;; Fallback: kill by PID if process object missing
  (when-let [pid (:pid @scroll-state)]
    (try
      (process ["kill" (str pid)])
      (catch Exception e
        (log "Error killing process by PID:" e))))
  (swap! scroll-state assoc :scrolling false :pid nil :direction nil))

(defn start-scroll [direction pixels-per-sec]
  (log "Starting scroll:" direction "at rate:" pixels-per-sec)
  (stop-scroll)
  (let [args (cond-> [scroll-binary (str pixels-per-sec)]
               (= direction "up") (conj "up"))]
    (try
      (let [proc (process args {:inherit true :shutdown "destroy" :start true})
            pid (:pid proc)]
        (reset! scroll-proc proc)
        (swap! scroll-state assoc
               :scrolling true
               :direction direction
               :pid pid
               :rate pixels-per-sec)
        (log "Started scroll process with PID:" pid))
      (catch Exception e
        (log "Error starting scroll process:" e)))))

(defn toggle-scroll [dir pixels-per-sec]
  (log "Toggle scroll request:" dir pixels-per-sec)
  (let [current-dir (:direction @scroll-state)]
    (if (= current-dir dir)
      ;; If we're already scrolling in this direction, check if we need to change speed
      (if (:scrolling @scroll-state)
        ;; Stop the current process and start a new one with the new speed
        (do
          (log "Already scrolling in direction" dir "- changing speed to" pixels-per-sec)
          (start-scroll dir pixels-per-sec))
        ;; If no process is running, just stop
        (stop-scroll))
      ;; If we're scrolling in a different direction or not scrolling, start in the new direction
      (start-scroll dir pixels-per-sec))))

(defn get-status []
  (log "Status request")
  (let [state @scroll-state]
    (log "Current state:" state)
    state))

;; Command processing function
(defn process-command [cmd-str]
  (log "Received command (raw):" (pr-str cmd-str))
  (try
    (let [cmd (read-string cmd-str)]
      (log "Parsed command:" (pr-str cmd))
      (cond
        (= cmd :stop) (do (log "Stopping scroll via :stop command") (stop-scroll))

        (and (vector? cmd) (= (first cmd) :toggle))
        (let [[_ dir rate] cmd
              dir (or dir "down")
              rate (or rate 60)]
          (log "Toggling scroll:" dir rate)
          (toggle-scroll dir (str rate)))

        (and (vector? cmd) (= (first cmd) :start))
        (let [[_ dir rate] cmd
              dir (or dir "down")
              rate (or rate 60)]
          (log "Starting scroll:" dir rate)
          (start-scroll dir (str rate)))

        (= cmd :status) (do (log "Status requested") (get-status))

        :else (log "Unknown command after parsing:" (pr-str cmd))))
    (catch Exception e
      (log "Error processing command:" e "for input:" (pr-str cmd-str) "\n" (.getMessage e)))))

;; Command processing loop
(log "Starting command listener on" command-pipe)
(future
  (while true
    (try
      (with-open [reader (io/reader command-pipe)]
        (log "Pipe opened, waiting for commands")
        (loop []
          (when-let [line (.readLine reader)]
            (when-not (str/blank? line)
              (process-command line))
            (recur))))
      (catch Exception e
        (log "Error reading from pipe:" e)
        (Thread/sleep 1000)))))

;; Command line interface for backward compatibility
(when (seq *command-line-args*)
  (let [[mode dir rate] *command-line-args*
        dir (or dir "down")
        rate (or rate "60")]
    (case mode
      "start"  (process-command (str [:start dir rate]))
      "stop"   (process-command ":stop")
      "toggle" (process-command (str [:toggle dir rate]))
      "daemon" (log "Running in daemon mode")
      (log "Usage: bb scroll.clj toggle|start|stop|daemon [up|down] [rate]"))))

;; Keep the process running if no command line args or daemon mode
(when (or (empty? *command-line-args*) 
          (= (first *command-line-args*) "daemon"))
  (log "Server running in daemon mode. Use the following to control:"
       "\necho ':stop' > " command-pipe
       "\necho '[:toggle \"down\" 60]' > " command-pipe)
  @(promise))