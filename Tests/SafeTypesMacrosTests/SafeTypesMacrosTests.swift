import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

#if canImport(Macros)
import Macros

let testMacros: [String: Macro.Type] = [
    "Positive" : PositiveMacro.self,
    "Negative" : NegativeMacro.self,
    "NonPositive" : NonPositiveMacro.self,
    "NonNegative" : NonNegativeMacro.self,
    "NonZero" : NonZeroMacro.self,
    "NonEmptyString" : NonEmptyStringMacro.self
]
#endif

final class SafeTypesMacros: XCTestCase {
    // MARK: - Positive

    func test_positiveMacro_whenPositiveIntegerLiteralArgument_evaluatesCorrectly() throws {
#if canImport(Macros)
        assertMacroExpansion(
            """
            #Positive(1)
            """,
            expandedSource: """
            Positive(1).unsafelyUnwrapped
            """,
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }

    func test_positiveMacro_whenPositiveDoubleLiteralArgument_evaluatesCorrectly() throws {
#if canImport(Macros)
        assertMacroExpansion(
            """
            #Positive(1.234)
            """,
            expandedSource: """
            Positive(1.234).unsafelyUnwrapped
            """,
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }

    func test_positiveMacro_whenNegativeIntegerLiteralArgument_throwsNotPositiveError() throws {
#if canImport(Macros)
        assertMacroExpansion(
            """
            #Positive(-1)
            """,
            expandedSource: """
            #Positive(-1)
            """,
            diagnostics: [
                .init(
                    message: "Should be positive",
                    line: 1,
                    column: 1,
                    severity: .error
                )
            ],
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }

    func test_positiveMacro_whenNegativeDoubleLiteralArgument_throwsNotPositiveError() throws {
#if canImport(Macros)
        assertMacroExpansion(
            """
            #Positive(-1.234)
            """,
            expandedSource: """
            #Positive(-1.234)
            """,
            diagnostics: [
                .init(
                    message: "Should be positive",
                    line: 1,
                    column: 1,
                    severity: .error
                )
            ],
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }

    func test_positiveMacro_whenZeroIntegerLiteralArgument_throwsNotPositiveError() throws {
#if canImport(Macros)
        assertMacroExpansion(
            """
            #Positive(0)
            """,
            expandedSource: """
            #Positive(0)
            """,
            diagnostics: [
                .init(
                    message: "Should be positive",
                    line: 1,
                    column: 1,
                    severity: .error
                )
            ],
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }

    func test_positiveMacro_whenZeroDoubleLiteralArgument_throwsNotPositiveError() throws {
#if canImport(Macros)
        assertMacroExpansion(
            """
            #Positive(0.0)
            """,
            expandedSource: """
            #Positive(0.0)
            """,
            diagnostics: [
                .init(
                    message: "Should be positive",
                    line: 1,
                    column: 1,
                    severity: .error
                )
            ],
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }

    func test_positiveMacro_whenNotNumericLiteralArgument_throwsNotNumericError() throws {
#if canImport(Macros)
        assertMacroExpansion(
            """
            #Positive("something")
            """,
            expandedSource: """
            #Positive("something")
            """,
            diagnostics: [
                .init(
                    message: "Should be number literal",
                    line: 1,
                    column: 1,
                    severity: .error
                )
            ],
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }

    // MARK: - Negative

    func test_negativeMacro_whenNegativeIntegerLiteralArgument_evaluatesCorrectly() throws {
#if canImport(Macros)
        assertMacroExpansion(
            """
            #Negative(-1)
            """,
            expandedSource: """
            Negative(-1).unsafelyUnwrapped
            """,
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }

    func test_negativeMacro_whenNegativeDoubleLiteralArgument_evaluatesCorrectly() throws {
#if canImport(Macros)
        assertMacroExpansion(
            """
            #Negative(-1.234)
            """,
            expandedSource: """
            Negative(-1.234).unsafelyUnwrapped
            """,
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }

    func test_negativeMacro_whenPositiveIntegerLiteralArgument_throwsNotNegativeError() throws {
#if canImport(Macros)
        assertMacroExpansion(
            """
            #Negative(1)
            """,
            expandedSource: """
            #Negative(1)
            """,
            diagnostics: [
                .init(
                    message: "Should be negative",
                    line: 1,
                    column: 1,
                    severity: .error
                )
            ],
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }

    func test_negativeMacro_whenPositiveDoubleLiteralArgument_throwsNotNegativeError() throws {
#if canImport(Macros)
        assertMacroExpansion(
            """
            #Negative(1.234)
            """,
            expandedSource: """
            #Negative(1.234)
            """,
            diagnostics: [
                .init(
                    message: "Should be negative",
                    line: 1,
                    column: 1,
                    severity: .error
                )
            ],
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }

    func test_negativeMacro_whenZeroIntegerLiteralArgument_throwsNotNegativeError() throws {
#if canImport(Macros)
        assertMacroExpansion(
            """
            #Negative(0)
            """,
            expandedSource: """
            #Negative(0)
            """,
            diagnostics: [
                .init(
                    message: "Should be negative",
                    line: 1,
                    column: 1,
                    severity: .error
                )
            ],
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }

    func test_negativeMacro_whenZeroDoubleLiteralArgument_throwsNotNegativeError() throws {
#if canImport(Macros)
        assertMacroExpansion(
            """
            #Negative(0.0)
            """,
            expandedSource: """
            #Negative(0.0)
            """,
            diagnostics: [
                .init(
                    message: "Should be negative",
                    line: 1,
                    column: 1,
                    severity: .error
                )
            ],
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }

    func test_negativeMacro_whenNotNumericLiteralArgument_throwsNotNumericError() throws {
#if canImport(Macros)
        assertMacroExpansion(
            """
            #Negative("something")
            """,
            expandedSource: """
            #Negative("something")
            """,
            diagnostics: [
                .init(
                    message: "Should be number literal",
                    line: 1,
                    column: 1,
                    severity: .error
                )
            ],
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }

    // MARK: - Non Positive

    func test_nonPositiveMacro_whenNegativeIntegerLiteralArgument_evaluatesCorrectly() throws {
#if canImport(Macros)
        assertMacroExpansion(
            """
            #NonPositive(-1)
            """,
            expandedSource: """
            NonPositive(-1).unsafelyUnwrapped
            """,
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }

    func test_nonPositiveMacro_whenNegativeDoubleLiteralArgument_evaluatesCorrectly() throws {
#if canImport(Macros)
        assertMacroExpansion(
            """
            #NonPositive(-1.234)
            """,
            expandedSource: """
            NonPositive(-1.234).unsafelyUnwrapped
            """,
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }

    func test_nonPositiveMacro_whenPositiveIntegerLiteralArgument_throwsPositiveError() throws {
#if canImport(Macros)
        assertMacroExpansion(
            """
            #NonPositive(1)
            """,
            expandedSource: """
            #NonPositive(1)
            """,
            diagnostics: [
                .init(
                    message: "Should not be positive",
                    line: 1,
                    column: 1,
                    severity: .error
                )
            ],
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }

    func test_nonPositiveMacro_whenPositiveDoubleLiteralArgument_throwsPositiveError() throws {
#if canImport(Macros)
        assertMacroExpansion(
            """
            #NonPositive(1.234)
            """,
            expandedSource: """
            #NonPositive(1.234)
            """,
            diagnostics: [
                .init(
                    message: "Should not be positive",
                    line: 1,
                    column: 1,
                    severity: .error
                )
            ],
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }

    func test_nonPositiveMacro_whenZeroIntegerLiteralArgument_evaluatesCorrectly() throws {
#if canImport(Macros)
        assertMacroExpansion(
            """
            #NonPositive(0)
            """,
            expandedSource: """
            NonPositive(0).unsafelyUnwrapped
            """,
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }

    func test_nonPositiveMacro_whenZeroDoubleLiteralArgument_evaluatesCorrectly() throws {
#if canImport(Macros)
        assertMacroExpansion(
            """
            #NonPositive(0.0)
            """,
            expandedSource: """
            NonPositive(0.0).unsafelyUnwrapped
            """,
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }

    func test_nonPositiveMacro_whenNotNumericLiteralArgument_throwsNotNumericError() throws {
#if canImport(Macros)
        assertMacroExpansion(
            """
            #NonPositive("something")
            """,
            expandedSource: """
            #NonPositive("something")
            """,
            diagnostics: [
                .init(
                    message: "Should be number literal",
                    line: 1,
                    column: 1,
                    severity: .error
                )
            ],
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }

    // MARK: - Non Negative

    func test_nonNegativeMacro_whenPositiveIntegerLiteralArgument_evaluatesCorrectly() throws {
#if canImport(Macros)
        assertMacroExpansion(
            """
            #NonNegative(1)
            """,
            expandedSource: """
            NonNegative(1).unsafelyUnwrapped
            """,
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }

    func test_nonNegativeMacro_whenPositiveDoubleLiteralArgument_evaluatesCorrectly() throws {
#if canImport(Macros)
        assertMacroExpansion(
            """
            #NonNegative(1.234)
            """,
            expandedSource: """
            NonNegative(1.234).unsafelyUnwrapped
            """,
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }

    func test_nonNegativeMacro_whenNegativeIntegerLiteralArgument_throwsNotPositiveError() throws {
#if canImport(Macros)
        assertMacroExpansion(
            """
            #NonNegative(-1)
            """,
            expandedSource: """
            #NonNegative(-1)
            """,
            diagnostics: [
                .init(
                    message: "Should not be negative",
                    line: 1,
                    column: 1,
                    severity: .error
                )
            ],
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }

    func test_nonNegativeMacro_whenNegativeDoubleLiteralArgument_throwsNotPositiveError() throws {
#if canImport(Macros)
        assertMacroExpansion(
            """
            #NonNegative(-1.234)
            """,
            expandedSource: """
            #NonNegative(-1.234)
            """,
            diagnostics: [
                .init(
                    message: "Should not be negative",
                    line: 1,
                    column: 1,
                    severity: .error
                )
            ],
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }

    func test_nonNegativeMacro_whenZeroIntegerLiteralArgument_evaluatesCorrectly() throws {
#if canImport(Macros)
        assertMacroExpansion(
            """
            #NonNegative(0)
            """,
            expandedSource: """
            NonNegative(0).unsafelyUnwrapped
            """,
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }

    func test_nonNegativeMacro_whenZeroDoubleLiteralArgument_evaluatesCorrectly() throws {
#if canImport(Macros)
        assertMacroExpansion(
            """
            #NonNegative(0.0)
            """,
            expandedSource: """
            NonNegative(0.0).unsafelyUnwrapped
            """,
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }

    func test_nonNegativeMacro_whenNotNumericLiteralArgument_throwsNotNumericError() throws {
#if canImport(Macros)
        assertMacroExpansion(
            """
            #NonNegative("something")
            """,
            expandedSource: """
            #NonNegative("something")
            """,
            diagnostics: [
                .init(
                    message: "Should be number literal",
                    line: 1,
                    column: 1,
                    severity: .error
                )
            ],
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }

    // MARK: - Non Zero

    func test_nonZeroMacro_whenPositiveIntegerLiteralArgument_evaluatesCorrectly() throws {
#if canImport(Macros)
        assertMacroExpansion(
            """
            #NonZero(1)
            """,
            expandedSource: """
            NonZero(1).unsafelyUnwrapped
            """,
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }

    func test_nonZeroMacro_whenPositiveDoubleLiteralArgument_evaluatesCorrectly() throws {
#if canImport(Macros)
        assertMacroExpansion(
            """
            #NonZero(1.234)
            """,
            expandedSource: """
            NonZero(1.234).unsafelyUnwrapped
            """,
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }

    func test_nonZeroMacro_whenNegativeIntegerLiteralArgument_evaluatesCorrectly() throws {
#if canImport(Macros)
        assertMacroExpansion(
            """
            #NonZero(-1)
            """,
            expandedSource: """
            NonZero(-1).unsafelyUnwrapped
            """,
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }

    func test_nonZeroMacro_whenNegativeDoubleLiteralArgument_evaluatesCorrectly() throws {
#if canImport(Macros)
        assertMacroExpansion(
            """
            #NonZero(-1.234)
            """,
            expandedSource: """
            NonZero(-1.234).unsafelyUnwrapped
            """,
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }

    func test_nonZeroMacro_whenZeroIntegerLiteralArgument_evaluatesCorrectly() throws {
#if canImport(Macros)
        assertMacroExpansion(
            """
            #NonZero(0)
            """,
            expandedSource: """
            #NonZero(0)
            """,
            diagnostics: [
                .init(
                    message: "Should not be zero",
                    line: 1,
                    column: 1,
                    severity: .error
                )
            ],
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }

    func test_nonZeroMacro_whenZeroDoubleLiteralArgument_evaluatesCorrectly() throws {
#if canImport(Macros)
        assertMacroExpansion(
            """
            #NonZero(0.0)
            """,
            expandedSource: """
            #NonZero(0.0)
            """,
            diagnostics: [
                .init(
                    message: "Should not be zero",
                    line: 1,
                    column: 1,
                    severity: .error
                )
            ],
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }

    func test_nonZeroMacro_whenNotNumericLiteralArgument_throwsNotNumericError() throws {
#if canImport(Macros)
        assertMacroExpansion(
            """
            #NonZero("something")
            """,
            expandedSource: """
            #NonZero("something")
            """,
            diagnostics: [
                .init(
                    message: "Should be number literal",
                    line: 1,
                    column: 1,
                    severity: .error
                )
            ],
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }

    // MARK: - Non Empty String

    func test_nonEmptyStringMacro_whenNonEmpty_evaluatesCorrectly() throws {
#if canImport(Macros)
        assertMacroExpansion(
            """
            #NonEmptyString("something")
            """,
            expandedSource: """
            NonEmptyString("something").unsafelyUnwrapped
            """,
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }

    func test_nonEmptyStringMacro_whenBlankCharacter_evaluatesCorrectly() throws {
#if canImport(Macros)
        assertMacroExpansion(
            """
            NonEmptyString(" ")
            """,
            expandedSource: """
            NonEmptyString(" ")
            """,
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }

    func test_nonEmptyStringMacro_whenEmpty_throwsEmptyError() throws {
#if canImport(Macros)
        assertMacroExpansion(
            """
            #NonEmptyString("")
            """,
            expandedSource: """
            #NonEmptyString("")
            """,
            diagnostics: [
                .init(
                    message: "Should not be empty",
                    line: 1,
                    column: 1,
                    severity: .error
                )
            ],
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }
}
