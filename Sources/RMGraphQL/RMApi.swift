import Foundation
import Apollo
import ApolloSQLite
import Api

public struct RMApi {
    let apolloClient: ApolloClient
    let logger: Logger

    public init(config: RMApiConfig, authBlock: AuthBlockType? = nil) throws {
        self.logger = Logger(loggingLevel: config.loggingLevel)

        let store = ApolloStore(cache: try config.cashingStrategy.getCache() )

        let client = URLSessionClient(sessionConfiguration: config.sessionConfiguration)
        let provider = NetworkInterceptorProvider(store: store, client: client, logger: logger, authBlock: authBlock, mockInterceptor: config.mockInterceptor)

        let url = config.endpont ?? rmApiEndpont
        let requestChainTransport = RequestChainNetworkTransport(interceptorProvider: provider, endpointURL: url)
        apolloClient =  ApolloClient(networkTransport: requestChainTransport, store: store)
    }

    public func fetchAllDeadCharacters() async throws -> GraphQLResult<DeadCharactersQuery.Data> {
        do {
            return try await withCheckedThrowingContinuation { continuation in
                apolloClient.fetch(query: DeadCharactersQuery()) { result in
                    switch result {
                    case .success(let data):
                        continuation.resume(returning: data)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            }

        } catch {
            throw RMError.asyncConvertionFailed
        }
    }
}

// MARK: - Private helpers

private extension CashingStrategy {
    func getCache() throws -> NormalizedCache {
        switch self {
        case .inMemory:
            return InMemoryNormalizedCache()
        case .sql:
            return try ApolloStore.createSqlCache()
        case .none:
            return NoCache()
        }
    }
}

private extension ApolloStore {
    static func createSqlCache() throws -> SQLiteNormalizedCache {
        let documentsPath = NSSearchPathForDirectoriesInDomains(
            .cachesDirectory,
            .userDomainMask,
            true
        ).first!

        let documentsURL = URL(fileURLWithPath: documentsPath)
        let sqliteFileURL = documentsURL.appendingPathComponent("rm_api_apollo_db.sqlite")

        do {
            return try SQLiteNormalizedCache(fileURL: sqliteFileURL)
        } catch {
            throw RMError.couldNotCreateSqlCache
        }
    }
}
