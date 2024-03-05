import SafeTypes

@freestanding(expression)
public macro Positive<Number: Numeric & Comparable>(_ value: Number) -> Positive<Number> = #externalMacro(module: "Macros", type: "PositiveMacro")

@freestanding(expression)
public macro Negative<Number: Numeric & Comparable>(_ value: Number) -> Negative<Number> = #externalMacro(module: "Macros", type: "NegativeMacro")

@freestanding(expression)
public macro NonPositive<Number: Numeric & Comparable>(_ value: Number) -> NonPositive<Number> = #externalMacro(module: "Macros", type: "NonPositiveMacro")

@freestanding(expression)
public macro NonNegative<Number: Numeric & Comparable>(_ value: Number) -> NonNegative<Number> = #externalMacro(module: "Macros", type: "NonNegativeMacro")

@freestanding(expression)
public macro NonZero<Number: Numeric & Comparable>(_ value: Number) -> NonZero<Number> = #externalMacro(module: "Macros", type: "NonZeroMacro")

@freestanding(expression)
public macro MinusOneToOne<Number: Numeric & Comparable>(_ value: Number) -> MinusOneToOne<Number> = #externalMacro(module: "Macros", type: "MinusOneToOneMacro")

@freestanding(expression)
public macro ZeroToOne<Number: Numeric & Comparable>(_ value: Number) -> ZeroToOne<Number> = #externalMacro(module: "Macros", type: "ZeroToOneMacro")

@freestanding(expression)
public macro NonEmptyString(_ value: String) -> NonEmptyString = #externalMacro(module: "Macros", type: "NonEmptyStringMacro")
