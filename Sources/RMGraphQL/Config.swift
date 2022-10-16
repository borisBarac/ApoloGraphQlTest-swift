import Foundation

public enum CashingStrategy {
    case inMemory
    case sql
}

public struct RMApiConfig {
    public let endpont: URL?
    public let loggingLevel: LoggingLevel
    public let cashingStrategy: CashingStrategy


    public init(endpont: URL?, loggingLevel: LoggingLevel, cashingStrategy: CashingStrategy) {
        self.endpont = endpont
        self.loggingLevel = loggingLevel
        self.cashingStrategy = cashingStrategy
    }

}
