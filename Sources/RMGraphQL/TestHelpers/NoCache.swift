import Apollo

public class NoCache: NormalizedCache {

  public init() { }

  public func loadRecords(forKeys keys: Set<String>) throws -> [String : Record] {
    return [:]
  }

  public func merge(records: RecordSet) throws -> Set<String> {
    return Set()
  }

  public func removeRecord(for key: String) throws { }

  public func removeRecords(matching pattern: String) throws { }

  public func clear() throws { }

}
