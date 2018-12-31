import Foundation

public struct Rex {

    // MARK: - Private attributes

    private let matcher: NSRegularExpression

    // MARK: - Init

    public init(pattern: String, options: NSRegularExpression.Options = []) throws {
        try self.matcher = NSRegularExpression(pattern: pattern, options: options)
    }

    // MARK: - Public methods

    public func match(_ string: String, options: NSRegularExpression.MatchingOptions = []) -> Match {
        let matches = matcher.matches(in: string, options: options, range: string.fullRange)
        return Match(string: string, rawMatches: matches)
    }

    public func matches(_ string: String) -> Bool {
        return matcher.firstMatch(in: string, options: [], range: string.fullRange) != nil
    }
}
