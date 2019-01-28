import Foundation

infix operator =~
infix operator !~

public func =~(string: String, pattern: String) -> Bool {
    return string.matches(pattern)
}

public func !~(string: String, pattern: String) -> Bool {
    return !string.matches(pattern)
}
