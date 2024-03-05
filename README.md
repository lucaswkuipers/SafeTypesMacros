# SafeTypesMacros
SafeTypesMacros is a _Swift_ package that extends [SafeTypes](https://github.com/lucaswkuipers/SafeTypes) by adding macro literal initializers for its types.

![macros](https://github.com/lucaswkuipers/SafeTypesMacros/assets/59176579/769a0cdb-0eda-4100-891b-71312990d716)

By ensuring conditions at compile time, SafeTypesMacros + [SafeTypes](https://github.com/lucaswkuipers/SafeTypes) allows developers to write more robust and expressive code with reduced boilerplate, increased performance, and improved documentation through its constrained types.

## Features

- Macros for non optional initializers for [SafeTypes](https://github.com/lucaswkuipers/SafeTypes) custom data types through literals (values checked at compile time).

- [x] Type-safe containers that prevent invalid states
- [x] Enforced runtime constraints at compile time
- [x] Enhanced code readability and maintainability
- [x] Simplified method interfaces and APIs
- [x] Streamlined unit testing by eliminating redundant unhappy-path checks

## Installation

### Swift Package Manager

Add the following to your `Package.swift` file's dependencies:

```swift
.package(url: "https://github.com/lucaswkuipers/SafeTypesMacros.git", from: "1.0.0")
```

If you are manipulating the resulting data type I recommend installing the [SafeTypes](https://github.com/lucaswkuipers/SafeTypes) library itself too:

```swift
.package(url: "https://github.com/lucaswkuipers/SafeTypes.git", from: "1.0.0")
```

And then import wherever needed: 

```swift
import SafeTypesMacros
import SafeTypes // Optionally
```

## Usage

Below are some of the Macros provided for `SafeTypes` and brief examples of their usage:

### Collections

#### [`NonEmptyString`](/Sources/Macros/Macros.swift)

Macro for string that's guaranteed to contain at least one character (can be blank or invisible character).

```swift
// ✅ Compiles

#NonEmptyString("Alice") // NonEmptyString
#NonEmptyString(" Bob ") // NonEmptyString
#NonEmptyString(" ") // NonEmptyString

// ❌ Fails

#NonEmptyString("") // String can't be empty
#NonEmptyString() // No argument
```

### Numbers

Where number is:

```swift
typealias Number = Numeric & Comparable
```

#### [`Positive`](/Sources/Macros/Macros.swift)

Macro for a number that is guaranteed to be greater than zero (value > 0)

```swift
// ✅ Compiles

#Positive(123) // Positive<Int>
#Positive(42.69) // Positive<Double>

// ❌ Fails

#Positive(-1) // Can't be negative
#Positive(0) // Can't be zero
#Positive() // No argument
```

#### [`Negative`](/Sources/Macros/Macros.swift)

Macro for A number that is guaranteed to be less than zero (value < 0)

```swift
// ✅ Compiles

#Negative(-123) // Negative<Int>
#Negative(-42.69) // Negative<Double>

// ❌ Fails

#Negative(1) // Can't be positive
#Negative(0) // Can't be zero
#Negative() // No argument
```

#### [`NonPositive`](/Sources/Macros/Macros.swift)

Macro for a number that is guaranteed to be less than or equal to zero (value <= 0)

```swift
// ✅ Compiles

#NonPositive(-123) // NonPositive<Int>
#NonPositive(-42.69) // NonPositive<Double>
#NonPositive(0) // NonPositive<Int>
#NonPositive(0.0) // NonPositive<Double>

// ❌ Fails

#NonPositive(1) // Can't be positive
#NonPositive() // No argument
```

#### NonNegative

Macro for number that is guaranteed to be greater than or equal to zero (value >= 0)

```swift
// ✅ Compiles

#NonNegative(123) // NonNegative<Int>
#NonNegative(42.69) // NonNegative<Double>
#NonNegative(0) // NonNegative<Int>
#NonNegative(0.0) // NonNegative<Double>

// ❌ Fails

#NonNegative(-273.15) // Can't be negative
#NonNegative() // No argument
```

#### NonZero

Macro for a number that is guaranteed to be different than zero (value != 0)

```swift
// ✅ Non Optional Initializers

#NonZero(123) // NonZero<Int>
#NonZero(42.69) // NonZero<Double>
#NonZero(-123) // NonZero<Int>
#NonZero(-42.69) // NonZero<Double>

// ❌ Fails to compile

#NonZero(0) // Can't be zero
#NonZero(0.0) // Can't be zero
#NonZero() // No argument
```

#### `MinusOneToOne`

Macro for number that's within the range of -1 to 1, inclusive. ([-1, 1])

```swift
// ✅ Compiles

#MinusOneToOne(-1) // MinusOneToOne<Int>
#MinusOneToOne(-1.0) // MinusOneToOne<Double>
#MinusOneToOne(-0.314159) // MinusOneToOne<Double>
#MinusOneToOne(0) // MinusOneToOne<Int>
#MinusOneToOne(0.0) // MinusOneToOne<Double>
#MinusOneToOne(0.1234) // MinusOneToOne<Double>
#MinusOneToOne(1) // MinusOneToOne<Double>

// ❌ Fails

#MinusOneToOne(-1.1) // Can't be less than -1
#MinusOneToOne(42.1) // Can't be greater than 1
#MinusOneToOne() // No Argument
```

#### `ZeroToOne`

Macro for number from 0 to 1, inclusive.

```swift
// ✅ Compiles
#ZeroToOne(0) // ZeroToOne<Int>
#ZeroToOne(0.0) // ZeroToOne<Double>
#ZeroToOne(0.1234) // ZeroToOne<Double>
#ZeroToOne(1) // ZeroToOne<Double>

// ❌ Fails

#ZeroToOne(-0.5) // Can't be less than 0
#ZeroToOne(42.1) // Can't be greater than 1
#ZeroToOne() // No argument
```

Each type guarantees compliance with its stated constraints so that your functions and methods can rely on those qualities and pass them on (preserving information).

## Contributing

Contributions are what make the open-source community such a fantastic place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Branch (`git checkout -b your_branch_name`)
3. Commit your Changes (`git commit -m 'Add some amazing feature'`)
4. Push to the Branch (`git push origin your_branch_name`)
5. Open a Pull Request

## License

Distributed under the MIT License. See [LICENSE](LICENSE) for more information.

## Contact

Feel free to reach out to me: 

[![image](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/lucaswk/)

## Acknowledgements

Some of the relevant sources of inspiration:

- [Point-Free's NonEmpty](https://github.com/pointfreeco/swift-nonempty)
- [Type Driven Design Article Series by Alex Ozun](https://swiftology.io/collections/type-driven-design/))


Thank you so much for considering [SafeTypes](https://github.com/lucaswkuipers/SafeTypes) and SafeTypesMacros for your next Swift project – I hope you find it as enjoyable to use as I found it to write!
