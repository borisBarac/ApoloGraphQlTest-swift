import Foundation

public enum CashingStrategy {
    case inMemory
    case sql
    case none
}

public struct RMApiConfig {
    public let endpont: URL?
    public let loggingLevel: LoggingLevel
    public let cashingStrategy: CashingStrategy
    public let sessionConfiguration: URLSessionConfiguration

    public init(endpont: URL?,
                loggingLevel: LoggingLevel,
                cashingStrategy: CashingStrategy,
                sessionConfiguration: URLSessionConfiguration = .default) {
        self.endpont = endpont
        self.loggingLevel = loggingLevel
        self.cashingStrategy = cashingStrategy
        self.sessionConfiguration = sessionConfiguration
    }

}
