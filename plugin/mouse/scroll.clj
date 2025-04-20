#!/usr/bin/env bb

(require '[babashka.process :refer [process]]
         '[babashka.fs :as fs]
         '[clojure.string :as str])

(def pid-file "/Users/ryan/.talon/user/community/plugin/mouse/smoothscroll.pid")
(def direction-file "/Users/ryan/.talon/user/community/plugin/mouse/smoothscroll.dir")
(def scroll-binary "/Users/ryan/.talon/user/community/plugin/mouse/smoothscroll")

(defn read-file-safe [f]
  (if (fs/exists? f)
    (try
      (str/trim (slurp f))
      (catch Exception _
        ;; Optionally log error here if needed in the future
        nil))
    nil))

(defn file-exists? [f]
  (fs/exists? f))

(defn stop-scroll []
  (println "Toggling off scroll")
  (let [pid (when (fs/exists? pid-file) (read-file-safe pid-file))]
    (when (and pid (not (str/blank? pid)))
      (println "Stopping PID:" pid)
      (try
        (process ["kill" pid])
        (Thread/sleep 100)
        (catch Exception _ nil)))) ; Ignore kill errors (process might already be dead)
  (fs/delete-if-exists pid-file)
  (fs/delete-if-exists direction-file))

(defn start-scroll [direction pixels-per-sec]
  (println "Starting to scroll:" direction)
  (Thread/sleep 100) ; Keep delay as it might have helped
  (stop-scroll)
  (let [args (cond-> [scroll-binary (str pixels-per-sec)]
               (= direction "up") (conj "up"))
        cmd (str "nohup " (str/join " " args) " > /dev/null 2>&1 & echo $!")]
    (try
      (let [{:keys [out]} (process ["sh" "-c" cmd] {:out :string})
            new-pid (str/trim @out)]
        (when-not (str/blank? new-pid)
          (try
            (fs/create-file pid-file)
            (spit pid-file new-pid)
            (fs/create-file direction-file)
            (spit direction-file direction)
            (println "Started scroll PID:" new-pid)
            (catch Exception e-spit
              (println "[ERROR] Failed to write state files:" e-spit)))))
      (catch Exception e-process
        (println "[ERROR] Error starting background process:" e-process)))))

(defn toggle-scroll [dir pixels-per-sec]
  (let [current-dir (read-file-safe direction-file)]
    (if (= current-dir dir)
      ;; If we're already scrolling in this direction, check if we need to change speed
      (let [current-pid (read-file-safe pid-file)]
        (if current-pid
          ;; Stop the current process and start a new one with the new speed
          (start-scroll dir pixels-per-sec)
          ;; If no process is running, just stop
          (stop-scroll)))
      ;; If we're scrolling in a different direction or not scrolling, start in the new direction
      (start-scroll dir pixels-per-sec))))

;; Command line usage: bb scroll.clj toggle|start|stop [up|down] [rate]
;; rate =  pixels per second
;; (which gets divided by 120 for high frequency hertz)

(let [[mode dir rate] *command-line-args*
      dir (or dir "down")
      rate (or rate "60")]
  (case mode
    "start"  (start-scroll dir rate)
    "stop"   (stop-scroll)
    "toggle" (toggle-scroll dir rate)
    (println "Usage: bb scroll.clj toggle|start|stop [up|down] [rate]")))