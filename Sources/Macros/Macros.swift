import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxMacros

public struct PositiveMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        let number = try node.getNumber()
        guard number.isPositive else {
            throw SafeTypesMacrosError.notPositive
        }
        return "Positive(\(raw: number)).unsafelyUnwrapped"
    }
}

public struct NegativeMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        let number = try node.getNumber()
        guard number.isNegative else {
            throw SafeTypesMacrosError.notNegative
        }
        return "Negative(\(raw: number)).unsafelyUnwrapped"
    }
}

public struct NonPositiveMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        let number = try node.getNumber()
        guard !number.isPositive else {
            throw SafeTypesMacrosError.positive
        }
        return "NonPositive(\(raw: number)).unsafelyUnwrapped"
    }
}

public struct NonNegativeMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        let number = try node.getNumber()
        guard !number.isNegative else {
            throw SafeTypesMacrosError.negative
        }
        return "NonNegative(\(raw: number)).unsafelyUnwrapped"
    }
}

public struct NonZeroMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        let number = try node.getNumber()
        guard !number.isZero else {
            throw SafeTypesMacrosError.zero
        }
        return "NonZero(\(raw: number)).unsafelyUnwrapped"
    }
}

public struct NonEmptyStringMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        let string = try node.getArgument()
        guard ExprSyntax("\(raw: string)").description.count > 2 else {
            throw SafeTypesMacrosError.empty
        }
        return "NonEmptyString(\(raw: string)).unsafelyUnwrapped"
    }
}

typealias Number = Numeric & Comparable

extension FreestandingMacroExpansionSyntax {
    func getArgument() throws -> String {
        guard let argument = argumentList.first?.expression.description else {
            throw SafeTypesMacrosError.missingArguments
        }
        return argument
    }

    func getNumber() throws -> any Number {
        let argument = try getArgument()

        if let integerNumber = Int(argument) {
            return integerNumber
        } else if let doubleNumber = Double(argument) {
            return doubleNumber
        } else {
            throw SafeTypesMacrosError.notNumberLiteral
        }
    }
}

@main
struct SafeTypesMacrosPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        PositiveMacro.self,
        NegativeMacro.self,
        NonPositiveMacro.self,
        NonNegativeMacro.self,
        NonZeroMacro.self,
        NonEmptyStringMacro.self
    ]
}

enum SafeTypesMacrosError: String, Error, CustomStringConvertible {
    case missingArguments = "Missing macro argument(s)"
    case notNumberLiteral = "Should be number literal"
    case notPositive = "Should be positive"
    case notNegative = "Should be negative"
    case positive = "Should not be positive"
    case negative = "Should not be negative"
    case zero = "Should not be zero"
    case empty = "Should not be empty"

    var description: String {
        rawValue
    }
}

extension Numeric where Self: Comparable {
    var isPositive: Bool {
        self > .zero
    }

    var isNegative: Bool {
        self < .zero
    }

    var isZero: Bool {
        self == .zero
    }
}
