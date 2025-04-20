import Cocoa

let pixelsPerSecond = CommandLine.arguments.count > 1 ? Double(CommandLine.arguments[1]) ?? 60.0 : 60.0
let interval: TimeInterval = 1.0 / 120.0  // Targeting 120 Hz
let step = pixelsPerSecond * interval
let direction: Double = CommandLine.arguments.contains("up") ? 1.0 : -1.0
let pidFile = "/tmp/smoothscroll.pid"

class ContinuousScroller {
    private var timer: Timer?
    private let step: Double
    private var fractionalDelta: Double = 0.0
    private let direction: Double

    init(step: Double, direction: Double) {
        self.step = step
        self.direction = direction
    }

    func start() {
        writePID()
        stop() // just in case
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in
            self?.scrollOnce()
        }
        RunLoop.current.add(timer!, forMode: .common)
    }

    func stop() {
        timer?.invalidate()
        timer = nil
        removePID()
    }

    private func scrollOnce() {
        fractionalDelta += step * direction
        let deltaY = Int32(round(fractionalDelta))
        fractionalDelta -= Double(deltaY)

        if deltaY != 0 {
            sendScrollEvent(deltaY: deltaY)
        }
    }

    private func sendScrollEvent(deltaY: Int32) {
        let event = CGEvent(scrollWheelEvent2Source: nil,
                            units: .pixel,
                            wheelCount: 1,
                            wheel1: deltaY,
                            wheel2: 0,
                            wheel3: 0)
        event?.post(tap: .cghidEventTap)
    }

    private func writePID() {
    let pid = getpid()
    do {
        try "\(pid)".write(toFile: "/tmp/smoothscroll.pid", atomically: true, encoding: .utf8)
        print("Wrote PID to \\(pidFile): \\(pid)")
    } catch {
        print("Could not write PID to file: \\(error)")
    }
}

    private func removePID() {
        try? FileManager.default.removeItem(atPath: pidFile)
    }
}

// Run until interrupted (key up or SIGINT)
signal(SIGINT) { _ in
    exit(0)
}

let scroller = ContinuousScroller(step: step, direction: direction)
scroller.start()
RunLoop.main.run()