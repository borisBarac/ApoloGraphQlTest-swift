import Foundation

// fallback endpoint if not provided in config
let rmApiEndpont = URL(string: "https://rickandmortyapi.graphcdn.app/")!

public enum RMError: Error {
    case asyncConvertionFailed
    case couldNotCreateSqlCache
}
