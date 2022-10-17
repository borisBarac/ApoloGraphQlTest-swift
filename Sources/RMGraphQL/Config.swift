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
    public let mockInterceptor: MockInterceptor?

    public init(endpont: URL?,
                loggingLevel: LoggingLevel,
                cashingStrategy: CashingStrategy,
                sessionConfiguration: URLSessionConfiguration = .default,
                mockInterceptor: MockInterceptor? = nil) {
        self.endpont = endpont
        self.loggingLevel = loggingLevel
        self.cashingStrategy = cashingStrategy
        self.sessionConfiguration = sessionConfiguration
        self.mockInterceptor = mockInterceptor
    }

}
