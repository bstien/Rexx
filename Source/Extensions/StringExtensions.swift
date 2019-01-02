import Foundation

// MARK: - Public extensions.

public extension String {
    public func matches(_ pattern: String) -> Bool {
        do {
            return try Rex(pattern: pattern).matches(self)
        } catch {
            return false
        }
    }

    public func match(_ pattern: String) -> Match  {
        do {
            return try Rex(pattern: pattern).match(self)
        } catch {
            return Match(string: self, rawMatches: [])
        }
    }
}

// MARK: - Internal extensions.

extension String {
    var fullRange: NSRange {
        return NSMakeRange(0, self.utf16.count)
    }

   func substring(with range: NSRange) -> String {
        return (self as NSString).substring(with: range)
    }
}
