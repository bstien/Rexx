import XCTest
@testable import Rex

class RexTests: XCTestCase {

    // MARK: - Failure tests

    func testItThrowsOnInvalidPattern() {
        // There is a lot of disallowed combinations in regex.
        // Some may not be completely self explanatory, so this is a short list of those.
        let invalidPatterns = [
            "(?<name>.) (?<name>.)",        // Multiple named capture groups with same identifier.
            "\\s**",                        // Multiple wildcard operators (**).
            "",                             // Empty pattern.
        ]

        for pattern in invalidPatterns {
            do {
                try _ = Rex(pattern: pattern)
                XCTFail("Rex did not fail with pattern: \(pattern)")
            } catch { }
        }
    }

    // MARK: - matches(string:) -> Bool

    func testSuccessfulMatch() throws {
        // Check if string starts with at least 1 digit.
        let string = "123 456 789"
        let pattern = "^\\d+"

        let rex = try Rex(pattern: pattern)
        XCTAssertTrue(rex.matches(string))
    }

    func testUnsuccessfulMatch() throws {
        // Check if string starts with 2 or 3 lowercased characters.
        let string = "123 456 789"
        let pattern = "^[a-z]{2,3}"

        let rex = try Rex(pattern: pattern)
        XCTAssertFalse(rex.matches(string))
    }

    // MARK: - Captures

    func testSingleCaptureGroup() throws {
        // Verify that string starts with at least 1 digit, and capture those numbers.
        let string = "123 456 789"
        let pattern = "^(\\d+)"

        let rex = try Rex(pattern: pattern)
        let result = rex.match(string)

        XCTAssertEqual(1, result.captures.count)
        XCTAssertEqual(1, result.captureRanges.count)

        let captures = ["123"]
        XCTAssertEqual(captures, result.captures)
    }

    func testMultipleCaptureGroups() throws {
        // Search for all combinations of multiple digits in sequence.
        let string = "123 456 789"
        let pattern = "(\\d+)"

        let rex = try Rex(pattern: pattern)
        let result = rex.match(string)

        XCTAssertEqual(3, result.captures.count)
        XCTAssertEqual(3, result.captureRanges.count)

        let captures = ["123", "456", "789"]
        XCTAssertEqual(captures, result.captures)
    }

    func testNonCapturingGroup() throws {
        // Make sure that we do not capture non-capturing groups.
        // These are marked with `(?:…)`.
        let string = "123 456 789"
        let pattern = "(?:\\d+)"

        let rex = try Rex(pattern: pattern)
        let result = rex.match(string)

        XCTAssertEqual(0, result.captures.count)
        XCTAssertEqual(0, result.captureRanges.count)
    }

    // MARK: - Named capture groups

    func testSingleNamedCaptureGroup() throws {
        // Named capture groups start with `(?<…>)`.
        // Capture the first name from the line.
        let string = "First name: Bastian - Last name: Stien"
        let pattern = "^First name: (?<firstName>\\w+)"

        let rex = try Rex(pattern: pattern)
        let result = rex.match(string)

        XCTAssertEqual(1, result.captures.count)
        XCTAssertEqual(1, result.captureRanges.count)

        let firstName = result.capture(withName: "firstName")
        XCTAssertNotNil(firstName)
        XCTAssertEqual("Bastian", firstName!)
    }

    func testMultipleNamedCaptureGroups() throws {
        // Named capture groups start with `(?<…>)`.
        // Capture both the first and last name from the line.
        let string = "First name: Bastian - Last name: Stien"
        let pattern = "^First name: (?<firstName>\\w+) - Last name: (?<lastName>\\w+)"

        let rex = try Rex(pattern: pattern)
        let result = rex.match(string)

        XCTAssertEqual(2, result.captures.count)
        XCTAssertEqual(2, result.captureRanges.count)

        let firstName = result.capture(withName: "firstName")
        XCTAssertNotNil(firstName)
        XCTAssertEqual("Bastian", firstName!)

        let lastName = result.capture(withName: "lastName")
        XCTAssertNotNil(lastName)
        XCTAssertEqual("Stien", lastName!)
    }
}
