# 🦖 Rexx

> _Simplifying_ regex in Swift

Regex in Swift is _much_ harder to both understand and use than it needs to be. If you've used regex in other languages, such as Ruby, Python or Perl, you already know how easy it should be! This library aims to reduce the amount of boilerplate code needed to just do a simple comparison between a `String` and a regex pattern, as well as fetch values from capture groups within a pattern.

But don't take my word for it, I have an example for you🤗 In both examples, we are only checking if a string matches a pattern.

**Swift API**

```swift
// 1. Your input string and the pattern. In this case, we want to check if the string starts with "Hello"
let myString = "Hello, World!"
let pattern = "^Hello"

// 2. Create an instance of NSRegularExpression with your pattern.
let regex = try! NSRegularExpression(pattern: pattern)

// 3. Define the range within the string you want to search for the pattern.
let range = NSRange(location: 0, length: myString.utf16.count)

// 4. Find the first match, if any, within the string.
let isMatch = regex.firstMatch(in: myString, options: [], range: range)

// 5. If isMatch isn't nil, we have a match!
if isMatch != nil {
    print("We have a match!")
}
```

**Rex**

```swift
// 1. Your input string and the pattern. As the example above, check if the string starts with "Hello".
let myString = "Hello, World!"
let pattern = "^Hello"

// 2. Check if the string matches the pattern.
if myString =~ pattern {
    print("We have a match!")
}
```



## Installation
`Rexx` is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'Rexx'
```

## Usage
You may either create an instance of `Rex`, use the operators or use the `String` extensions. Choose what you need depending on your usecase.

If you only have a single string you need to match against a pattern, there exists two operators as well as two methods you can use.

### Using `Rex`
An instance of `Rex` takes a pattern and an optional list of [`NSRegularExpression.Options`](https://developer.apple.com/documentation/foundation/nsregularexpression/options). This is the preferred way if you're going to match several strings against the same pattern, or if you need to provide options.

`Rex` has two methods:

- `matches(string:) -> Bool`
- `match(string:options:) -> Match`

The former only checks if the pattern is a match against the provided string, while the latter let's you also fetch values from capture groups within the pattern. The result of the match is provided through [`Match`](https://github.com/bstien/Rex/blob/master/Source/Match.swift). 

If you're on iOS 11+ you may also fetch values from named capture groups easily!😄 This is not available in earlier versions, due to [`range(withName:)`](https://developer.apple.com/documentation/foundation/nstextcheckingresult/2915200-range) being introduced in iOS 11.

```swift
// 1. Define your pattern. Match against a string starting with "Hello, " and ending with "!". Capture whatever name/word we're saying hello to.
let pattern = "^Hello, (?<name>\\w+)!$"

// 2. Create an instance of Rex with the pattern. You can also provide options through the `options:` parameter.
// Please note that the instantiation may fail, hence the 'try'-keyword, if the pattern has errors. Se
let rex = try Rex(pattern: pattern)

// 3. Match against a string.
let match = rex.match("Hello, World!")

// 4.1 Fetch the name we captured within the first capture group.
if let name = match.captures.first {
    print("We said hello to", name)
}

// 4.2 iOS 11+ only! Fetch the name captured within the capture group, which is a named capture group.
if let name = match.capture(withName: "name") {
    print("We said hello to", name)
}
```

### Operators: `=~` & `!~`
If you only need to check if a string matches a pattern, the operators are probably the easiest way to use `Rex`. Just place your string on the **left side** of the operator and the pattern on the **right side** and you're good to go!

**NB!** Please note that if your pattern is invalid Swift regex, these operators will return `false` for `=~` and `true` for `!~`. Since these cases are _haaard_ to debug, but I would advise you to check your pattern in i.e. [RegExr](https://regexr.com/), an online tool to test patterns.

#### Pattern matching
If you need to check if a string matches you're pattern, use the `=~` operator. It returns `true` if the string matches the pattern.

```swift
if "Hello, World!" =~ "^Hello" {
    // 👌 The string starts with "Hello".
}

if "123456789" =~ "^\\d+$" {
    // 👌 The string contains only digits.
}
```

#### Negated pattern matching
Sometimes you may want to check for negative matches. In these cases you may use the operator `!~`, which returns `true` if the string **does not** match the pattern.

```swift
if "Only letters and-symbols_here !()?\\" !~ "\\d" {
    // 👌 The string does not contain any digits.
}


if "123456abcd" !~ "^[a-zA-Z]" {
    // 👌 The string does start with any letters.
}
```

### String extensions
The extensions are as easily used as the operators, but it has the benefit of not using custom operators. They let you either check for a match against a pattern, or fetch captured values from the pattern.

The methods are pretty similar to those of `Rex`, but doesn't force you to create an instance of it.

- `matches(pattern:) -> Bool`
- `match(pattern:) -> Match`

#### Pattern matching
Check if your string matches the pattern.

```swift
if "Hello, World!".matches("^Hello") {
    // 👌 The string starts with "Hello".
}

if "1234".matches("^\\d+$") {
    // 👌 The string contains only digits.
}
```

#### Capturing values
Check if your string matches the pattern and capture values from capture groups.

```swift
// Fetch the name in capture group 1, which is also a named capture group.
let pattern = "^Hello, (?<name>\\w+)!$"
let match = "Hello, World!".match(pattern)

// Get the name from the first capture group.
if let name = match.captures.first {
    // 👌 The string matches, and we have the name!
}

// iOS 11+ only! Get the name from the capture group named 'name'.
if let name = match.capture(withName: "name") {
    // 👌 The string matches, and we have the name!
}
```

