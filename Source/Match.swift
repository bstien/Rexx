import Foundation

public struct Match {

    // MARK: - Private attributes

    private let rawMatches: [NSTextCheckingResult]

    // MARK: - Public attributes

    public let string: String
    public private(set) var captures: [String]
    public private(set) var captureRanges: [NSRange]

    // MARK: - Init

    init(string: String, rawMatches: [NSTextCheckingResult]) {
        self.string = string
        self.rawMatches = rawMatches
        self.captures = []
        self.captureRanges = []

        rawMatches.forEach {
            for rangeIndex in 1..<$0.numberOfRanges {
                let range = $0.range(at: rangeIndex)
                captureRanges.append(range)

                let substring = string.substring(with: range)
                captures.append(substring)
            }
        }
    }

    // MARK: - Public methods

    public var hasMatches: Bool {
        return captures.count > 0
    }

    @available(iOS 11.0, *)
    public func capture(withName name: String) -> String? {
        let notFoundRange = NSMakeRange(NSNotFound, 0)
        return rawMatches.map { $0.range(withName: name) }.filter { !NSEqualRanges(notFoundRange, $0) }.first.map { string.substring(with: $0) }
    }
}
