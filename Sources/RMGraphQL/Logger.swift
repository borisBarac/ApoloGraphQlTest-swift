import Foundation

public enum LoggingLevel: Int {
    case none = 0
    case error
    case all
}

enum LogType {
    case normal
    case error
    case important
}

class Logger {
    let loggingLevel: LoggingLevel
    var history = [String]()

    init(loggingLevel: LoggingLevel) {
        self.loggingLevel = loggingLevel
    }

    func log(message: String, logType: LogType = .normal, file: String = #file, line: Int = #line) {
        let startSymbol = startLogSymbol(logType)
        let message = "\(startSymbol) \(file): line \(line) - \(message)"
        history.append(message)

        switch loggingLevel {
        case .none:
            return
        case .all:
            print(message)
        case .error:
            logType == .error ? print(message) : ()
        }
    }

    private func startLogSymbol(_ logType: LogType) -> String {
        switch logType {
        case .normal:
            return "ℹ️"
        case .error:
            return "🔴"
        case .important:
            return "‼️"
        }
    }

}
