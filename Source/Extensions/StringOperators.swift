import Foundation

infix operator =~
infix operator !=~

func =~(string: String, pattern: String) -> Bool {
    return string.matches(pattern)
}

func !=~(string: String, pattern: String) -> Bool {
    return !string.matches(pattern)
}
