# Scrumdinger App (Learning Swift)

Just following the tutorial to gain some experience working with Swift and SwiftUI.

[AWS get started for when application is finished](https://aws.amazon.com/tw/mobile/mobile-application-development/native/ios/)

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [Scrumdinger App (Learning Swift)](#scrumdinger-app-learning-swift)
  - [Struct vs Enum vs Class](#struct-vs-enum-vs-class)
  - [Properties](#properties)
  - [Closure](#closure)
    - [Completion Closure using `escaping` and `nonescaping`](#completion-closure-using-escaping-and-nonescaping)
    - [`$0` `$1` access numbered argument](#0-1-access-numbered-argument)
  - [`some` keyword](#some-keyword)
  - [`throw` keyword](#throw-keyword)
  - [Private(set)](#privateset)
  - [Optional](#optional)
    - [Optional Binding](#optional-binding)
    - [Optional Chaining](#optional-chaining)
    - [Using the Nil-Coalescing Operator](#using-the-nil-coalescing-operator)
    - [Unconditional Unwrapping](#unconditional-unwrapping)
  - [Strong `?` and `weak` reference](#strong--and-weak-reference)
  - [where](#where)
  - [Asynchronous](#asynchronous)
    - [Asynchronous vs Parallelism](#asynchronous-vs-parallelism)
    - [Defining `async` function and calling `await`](#defining-async-function-and-calling-await)
    - [Task](#task)
  - [Actor Pattern (reference type)](#actor-pattern-reference-type)
    - [`@MainActor` annotation](#mainactor-annotation)
    - [`isolated` and `nonisolated` function](#isolated-and-nonisolated-function)
  - [ProgressView](#progressview)
  - [Text and Label](#text-and-label)
  - [HStack abd VStack](#hstack-abd-vstack)
  - [List(vector\[i\]) { in i }](#listvectori--in-i-)
  - [NavigationStack](#navigationstack)
  - [.accessibilityelement and label](#accessibilityelement-and-label)
  - [`@State` and `@Binding` (only works for value type, e.g. structures and enumerations)](#state-and-binding-only-works-for-value-type-eg-structures-and-enumerations)
  - [Reference Type `@object`](#reference-type-object)
  - [Form and TextField](#form-and-textfield)
  - [Modality](#modality)
    - [modal sheet (page is partially covers the underlying content)](#modal-sheet-page-is-partially-covers-the-underlying-content)
  - [App structures](#app-structures)
    - [Scene](#scene)
    - [Event and state](#event-and-state)
    - [View life cycle event](#view-life-cycle-event)
  - [Availability feature: `#/@available`](#availability-feature-available)
  - [Error](#error)
  - [App sandbox and `xcrun` command](#app-sandbox-and-xcrun-command)

<!-- markdown-toc end -->

## Struct vs Enum vs Class

Need to study further to clarify which one are value and reference type.

Enum are $sum$, struct are $product$. Where the former can only be as one type at a given time, while the latter can be multiple types.

## Properties

[ref](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/properties/#app-top)

Properties are values that are associated to a class, structure, or enumeration. Think of it as the same as class variables in C++ class.

There are three types of properties.

1. Stored Properties: `let`/`var` as part of instance.
2. Computed Properties: C++ style getter that computed via stored prop.
3. Type Properties: Properties that are associated with the type itself (i.e. `static`).

Stored properties can be lazy, where initial value isn’t calculated until the first time it’s used.

There is also properties observers, property wrapper, and global/local.

## Closure

Closure is a block of code that you can assign to a variable. It can be pass around, say to another function.

function without `func` key word to create.

``` swift
{ (parameters) -> returnType in
   // statements
}
```

It can have neither, one of, or both parameters and return type.

> Closure parameters does not require name, only type.

It can also create a function that accepts closure as its parameter.

``` swift
// define a function
func grabLunch(search: () -> ()) {
  …
  // closure call
  search()  
}

// function call
grabLunch(search: {
  print("Alfredo's Pizza: 2 miles away")
})
```

There is also trailing closure. Function can be classed without mentioning the name of the parameter.

```swift
func grabLunch(message: String, search: ()->()) {
   print(message)
   search()
}

// use of trailing closure
grabLunch(message:"Let's go out for lunch")  {
  print("Alfredo's Pizza: 2 miles away")
}

// Output
// Let's go out for lunch
// Alfredo's Pizza: 2 miles away
```

There is also `@autoclosure` that can be use at parameter to automatically adds curly braces.

> Turns out there can be multiple trailing closure! Where the first doesn't need a label, while the rest are required one.

Following is an example where a view taking two closure, while the preview provider only naming the second (and last) closure.

``` swift
struct CollapsibleMinSecPicker<MinutesValue, SecondsValue, Label, Content>: View where MinutesValue: Hashable, SecondsValue: Hashable, Label: View, Content: View {
    @Binding var minutes: MinutesValue
    @Binding var seconds: SecondsValue
    @ViewBuilder let label: () -> Label
    @ViewBuilder let content: () -> Content
    
    var body: some View {
		// ... some code ...
    }
}

struct CollapsibleMinSecPicker_PreviewProvider: PreviewProvider {
    static var previews: some View {
        CollapsibleMinSecPicker(minutes: .constant(1), seconds: .constant(1)) {  // this is already the label closure.
            Text("Duration")
        } content: {  // notice where only content needs a label.
            Text("Picker Content")
        }
    }
}
```

### Completion Closure using `escaping` and `nonescaping`

Completion handlers allows closure to escape and return to the function, essentially how async is done without syntactic sugar on top.

The main difference between completion handlers and async await is that completion handlers use callbacks to handle the results of asynchronous operation that can lead to deeply nested code which also leads to hard error marking.

Meanwhile, asynchronous functions are written sequentially.

### `$0` `$1` access numbered argument

[Very good answer](https://developer.apple.com/forums/thread/124678?answerId=389639022#389639022)

`$` allow closure to access the argument number passed (i.e. `$0` is shortcut to access the first argument).

## `some` keyword

swift provides a function called `protocol` for generics and type erasure, which is used to indicate that a function or property will return a value of a specific type that conforms to a protocol, but the exact type is not specified.

## `throw` keyword

Throwing function mark with the keyword `throw` are for error handling. If a function 'throws' fails the error will be thrown at you and swift requires you to fix the error.

> Throwing function and functions that return optional inherently different!

## Private(set)

A way to make `var` getable from public but not setable from public (only setable from private).

## Optional

Optionals is a swift type, it is either a wrapped value or the absence of a date.

```swift
let shortForm: Int? = Int("42")  // Same thing as below.
let longForm: Optional<Int> = Int("42")
```

### Optional Binding

Using either `if let`, `guard let`, `switch`, binding the optional variable to access it.

```swift
if let i = shortForm {
  print ("\(i)")
} else {
  print("No value")
}
// This if-else statement prints 1.
```

### Optional Chaining

Access using postfix optional chaining operator (postfix ?).

```swift
if let shortFrom = optional as? Int { print("true") }
```

### Using the Nil-Coalescing Operator

Default value can be supplied via `??` operator. You can also chain `??` to multiple optionals.

```swift
let defaultImagePath = "/images/default.png"
let heartPath = imagePaths["heart"] ?? defaultImagePath
print(heartPath)
// Prints "/images/default.png"
```

### Unconditional Unwrapping

If a optional is certain to be a value and not null. Postfix `!` can be used to force unwrap the value.

```swift
let isPNG = imagePaths["star"]!.hasSuffix(".png")
print(isPNG)
// Prints "true"
```

## Strong `?` and `weak` reference

Object in Swift are of reference type (all instance of a class shares the same copy of data), where ARC (automatic reference counting) handles new and delete. Assign `nil` to deallocate, which will call `deinit(){}`.

> Default value of an optional is nil.

Strong reference does not allow deallocation by ARC. ARC will always be $>=1$.

Weak reference inversely allow deallocation by ARC. ARC will never be i $>1$.

``` swift
var someInt: Int? // This is a strong reference.
```

``` swift
weak var colleague: Employee? // This is a weal reference. 
```

Class type must be of optional in order to assign `nil`.

> Remember to use `:` and not `=`.

``` swift
sabby?.colleague = cathy // Use ?
```

> By default property are strong type.

## where

`where` can be used as a keyword to filter. They can be used in a for loop, protocol extensions, first, contains, and initialisers.

```swift
for i in nums where nums % 2 == 0 { /* prints only even. */ }
```

```swift
extension Array where Element == Int { /* only do this to Array elements that are of type Int. */ }
```

`.first` gets the first element in an array, with `where` to add conditions.

```swift
let names = ["Henk", "John", "Jack"]
let firstJname = names.first(where: { (name) -> Bool in
    return name.first == "J"
}) // Returns John
```

`.contains` with `where` use to condition matching an element of an array

```swift
let fruits = ["Banana", "Apple", "Kiwi"]
let containsBanana = fruits.contains(where: { (fruit) in
    return fruit == "Banana"
}) // Returns true
```

## Asynchronous

[Link to reference article](https://developer.apple.com/tutorials/app-dev-training/adopting-swift-concurrency)

[Link to official documentation](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/)

[Link to interview questions and answers](https://growwithanyone.medium.com/async-await-in-ios-advanced-questions-and-answers-for-interviews-5fb3243c311b)

> Main thread executes all UI work, delivers all user events (e.g. taps, swipes)

If main threads does too much work, app performance will decrease. Main thread stalling (i.e. waiting for fetch data) can also delay view updates and event handling.

Need to find balance between executing on main thread when necessary, and execute on a background thread when possible.

### Asynchronous vs Parallelism

Asynchronous code can be *suspended and resumed* later. While async code suspend (i.e. `await`) it can do other short-term work (e.g. updating UI), and resume back to long-term work (e.g. fetching internet with slow connection).

An asynchronous function in Swift can give up the thread that it’s running on, which lets another asynchronous function run on that thread while the first function is blocked. When an asynchronous function resumes, Swift doesn’t make any guarantee about which thread that function will run on.

Parallelism is MPI, just multiple task continuing simultaneously.

### Defining `async` function and calling `await`

``` swift
final class UserStore {
    func fetchParticipants() async -> [Participant] {...}
}
```

and to use an `async` function one must use `await` to call the function.

The `await` keyword is used to mark possible (might) *suspension* the execution of an asynchronous function until the awaited asynchronous operation completes. It ensures that the subsequent code does not execute until the awaited operation finishes

> This is also called *yielding the thread*. Swift suspend the current execution of the thread and run some other code on that thread instead.

### Task

To call an asynchronous task, one has to call it in an asynchronous context, meaning async func has to be inside async func.

Many API calls are synchronous, to use such async function inside, it has to be enclose inside `Task` to create the async context.

## Actor Pattern (reference type)

[Link to reference article](https://www.avanderlee.com/swift/actors/)

`actor` can be used to create actor in swift which the compiler static checks and prevents actor state from data race.

Essentially meaning actor can safely access mutable state while being asynchronous.

Everything is an actor, that can send finite number of messages, that can spawn finite number of actor, that can designate their own behaviors.

``` swift
actor ChickenFeeder {
    let food = "worms" // needs init definition (struct does not).
    var numberOfEatingChickens: Int = 0
}
```

> Different to class, actor does not support inheritances, and tho is a reference type does not refer to the same data like class does.

### `@MainActor` annotation

Because UI update has to be handled by the main thread, and asynchronous function might execute on a background thread, `@MainActor` annotation ensure a class that all property mutation on said class is handled on the main thread only.

### `isolated` and `nonisolated` function

In comparison to `async` it does not use lock or mutex. Making it easier to use.

Because `actor`s in Swift the compiler handles all the synchronisation, we cannot directly read mutable (`var`), only immutable (`let`) are allowed.

One way to read mutable keyword is to use `await`, when no thread is accessing the data.

``` swift
let feeder = ChickenFeeder()
await feeder.chickenStartsEating()
print(await feeder.numberOfEatingChickens) // Prints: 1 
```

`isolated` essentially provide the above function in actor, a way to access properties that requires synchronized access (meaning need the use of `await`). Actor methods are `isolated` by default.

`nonisolated` can be used in compute method that does not depend on any mutable variable, making it concurrent.

## ProgressView

Essential a loading bar.

## Text and Label

Used to add text or text with label.

## HStack abd VStack

Creating a stack allows item to render in a stack fashion (either hori or vert).
(alignment: .leading/.trailing)

## List(vector[i]) { in i }

Create a list of the given object.

## NavigationStack

Add clickable item going to other views. use `.navigationTItle` to add title, and `.toolbar` to add extra function.

## .accessibilityelement and label

For voice over.

## `@State` and `@Binding` (only works for value type, e.g. structures and enumerations)

`@State` defines source of truth, meaning this is where the data is from, all other view using this data will reference the source of truth to get the data. Good practice to add `private` so the data can only be mutated within the view.
`@Binding` defines a mutable value that pass down from parent function's variable with `@State` binding.

Use a .constant binding to create an immutable value when using live\_preview

Remember to use `$` to pass `@State` source of truth to child function that takes `@Binding` in order for the child function to change alter its value.

## Reference Type `@object`

property wrappers that declare a reference type as a source of truth: `@ObservedObject`, `@StateObject`, and `@EnvironmentObject`.

Within a class use `@Published` on var within an `@ObservableObject` will cost those var to trigger update to SwiftUI object observers before published properties change.

`@StateObject` can be used to create an observable object and use it through out its lifetime. A good practice for managing memory resources instead of creating and destroying the instance every time there is a view update.

`@ObservedObject` indicates a view received an object from a parent source. Does not need an initial value because it is an received object.

`@StateObject` passed to child via `.environmentObject` can be placed inside the child, then by using `@EnvironmentObject` any grandchild will have references to the object even if the intermediate views does not have the object.

`@EnvironmentObject` is a good way to model data where child doesn't need the view while the grandchild needs it.

## Form and TextField

## Modality

<https://developer.apple.com/design/human-interface-guidelines/modality>

### modal sheet (page is partially covers the underlying content)

## App structures

App -> Scene -> View

Scene + View => Window

### Scene

Scene can be active to/from inactive, or from inactive to/from background

Current state of the scene can be read from environment value `scenePhase`. It good to have actions to perform while scene transitions to another phase (e.g. trigger app data save when scene phase becomes inactive).

Inactive scene doesn't receive events and can free any unnecessary resources.

``` swift
@Environment(\.scenePhase) private var scenePhase  // Example
```

Observe this variable, one can save data when it is `==` inactive.

### Event and state

SwiftUI follows declarative programming patterns, *view* render *UI* event *code* mutate *source of truth* update *view*.

### View life cycle event

`onAppear(preform:)` trigger actions when view appears.

`onDisappear(perform:)` trigger actions when view disappears.

`task(priority:_:)` trigger actions that execute asynchronously before the view appears on screen.

## Availability feature: `#/@available`

The Swift availability features enable you to maintain a single code base for an app that runs in multiple versions of iOS.

With each version of ios updates, the API framework versions follows. Using the `#available` or `@available` attribute can specific a section of code to only run by a specific version of ios, since the device.

``` swift
if #available(iOS 16.0, *) {  // Use # for section of code.
  // Code for device running IOS 16.
} else { 
  // Code for other IOS version
}
```

``` swift
@available(iOS 16.0, *)
struct SampleStruct: Struct {
  // Only usable for IOS 16 or later. Without availability check.
}
```

## Error

> Use `enum` to conforms to `Error` type because enumerations represents a finite number of values.

```swift
enum SampleError: Error { case errorRequired }
```

```swift
var error: MachineError

var body: some View {
    Text(error.localizedDescription)  // LD returns error as string.
}
```

## App sandbox and `xcrun` command

App sandbox is an ios container that let simulator have limited system resources and data to a contained part of the the developing system.

`xcrun` can be used to control simulator, specific the `xcrun simctl` command.

```swift
xcrun simctl get_app_container booted Bundle.Identifier data  // Return app data path.
```

```swift
xcrun simctl list  // Return all available UDID.
```

Loads more commands that can be used that are not mentioned here.
