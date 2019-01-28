import XCTest
@testable import Rex

class StringExtensionTests: XCTestCase {

    // MARK: - String.matches(pattern:)

    func testSuccessfulMatch() {
        // Verify that string only contains digits.
        var isMatch = "123".matches("^\\d+$")
        XCTAssertTrue(isMatch)

        // Verify that string contains one of two substrings.
        isMatch = "123".matches("(123)|(456)")
        XCTAssertTrue(isMatch)
    }

    func testUnsuccessfulMatch() {
        // Check if string starts with a lowercased character.
        var isMatch = "123".matches("^[a-z]")
        XCTAssertFalse(isMatch)

        // Check if string only contains uppercased characters.
        isMatch = "lowercased".matches("^[A-Z]$")
        XCTAssertFalse(isMatch)
    }

    // MARK: - Infix operator: =~

    func testSuccessfulInfixMatch() {
        // Verify that string only contains digits.
        XCTAssertTrue("123" =~ "^\\d+$")

        // Verify that string contains one of two substrings.
        XCTAssertTrue("123" =~ "(123)|(456)")
    }

    func testUnsuccessfulInfixMatch() {
        // Check if string starts with a lowercased character.
        XCTAssertFalse("123" =~ "^[a-z]")

        // Check if string only contains uppercased characters.
        XCTAssertFalse("lowercased" =~ "^[A-Z]$")
    }

    // MARK: - Negated infix operator: !~

    func testSuccessfulInfixNoMatch() {
        // Verify that string does not contain characters.
        XCTAssertTrue("123" !~ "[a-zA-Z]")

        // Verify that string does not start with letter 'a' or 'b'.
        XCTAssertTrue("Some string" !~ "^(a|b)")
    }

    func testUnsuccessfulInfixNoMatch() {
        // Verify that string does not contain multiple digits.
        XCTAssertFalse("123" !~ "[0-9]+")

        // Verify that string does not start with letter 'a' or 'b'.
        XCTAssertFalse("abc" !~ "^(a|b)")
    }
}
