# Scrumdinger App (Learning Swift)

Just following the tutorial to gain some experience working with Swift and SwiftUI.

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [Scrumdinger App (Learning Swift)](#scrumdinger-app-learning-swift)
  - [Clousure](#clousure)
  - [`some` keyword](#some-keyword)
  - [Private(set)](#privateset)
  - [Strong `?` and `weak` reference](#strong--and-weak-reference)
  - [Actor Pattern (reference type)](#actor-pattern-reference-type)
    - [`isolated` and `nonisolated` function](#isolated-and-nonisolated-function)
  - [ProgressView](#progressview)
  - [Text and Label](#text-and-label)
  - [HStack abd VStack](#hstack-abd-vstack)
  - [List(vector\[i\]) { in i }](#listvectori--in-i-)
  - [NavigationStack](#navigationstack)
  - [.accessibilityelement and label](#accessibilityelement-and-label)
  - [`@State` and `@Binding` (only works for value type, e.g. structures and enumerations)](#state-and-binding-only-works-for-value-type-eg-structures-and-enumerations)
  - [Reference Type (object)](#reference-type-object)
  - [Form and TextField](#form-and-textfield)
  - [Modality](#modality)
    - [modal sheet (page is partially covers the underlying content)](#modal-sheet-page-is-partially-covers-the-underlying-content)
  - [App structures](#app-structures)
    - [Scene](#scene)
    - [Event and state](#event-and-state)
    - [View life cycle event](#view-life-cycle-event)

<!-- markdown-toc end -->

## Clousure

function without `func` key word to create.

``` swift
{ (parameters) -> returnType in
   // statements
}
```

It can have neither, one of, or both parameters and return type.

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

## `some` keyword

swift provides a function called `protocol` for generics and type erasure, which is used to indicate that a function or property will return a value of a specific type that conforms to a protocol, but the exact type is not specified.

## Private(set)

A way to make `var` getable from public but not setable from public (only setable from private).

## Strong `?` and `weak` reference

Object in Swift are of reference type (all instance of a class shares the same copy of data), where ARC (automatic reference counting) handles new and delete. Assign `nil` to deallocate, which will call `deinit(){}`.

Strong reference does not allow deallocation by ARC. ARC will always be $>=1$.

Weak reference inversely allow deallocation by ARC. ARC will never be i $>1$.

``` swift
var someInt: Int? // This is a strong reference.
```

``` swift
weak var colleague: Employee? // This is a weal reference. 
```

Class type must be of optional in order to assign `nil`.

``` swift
sabby?.colleague = cathy // Use ?
```

> By default property are strong type.

## Actor Pattern (reference type)

[Link to reference artical](https://www.avanderlee.com/swift/actors/)

`actor` can be used to create actor in swift which the compiler static checks and prevents actor state from data race.

Everything is an actor, that can send finite number of messages, that can spawn finite number of actor, that can designate their own behaviors.

``` swift
actor ChickenFeeder {
    let food = "worms" // needs init definition (struct does not).
    var numberOfEatingChickens: Int = 0
}
```

> Different to class, actor does not support inheritances, and tho is a reference type does not refer to the same data like class does.

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

`@State` defines source of truth, meaning this is where the data is from, all other view using this data will reference the source of truth to get the data. Good practics to add `private` so the data can only be mutated within the view.
`@Binding` defines a mutable value that pass down from parent function's variable with `@State` binding.

Use a .constant binding to create an immutable value when using live\_preview

Remember to use `$` to pass `@State` source of truth to child function that takes `@Binding` in order for the child function to change alter its value.

## Reference Type (object)

property wrappers that declare a reference type as a source of truth: `@ObservedObject`, `@StateObject`, and `@EnvironmentObject`.

Within a class use `@Published` on var within an `@ObservableObject` will cost those var to trigger update to SwiftUI object observers when any published properties change.

`@StateObject` can be used to create an observable object.

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

### Event and state

SwiftUI follows declarative programming patterns, *view* render *UI* event *code* mutate *source of truth* update *view*.

### View life cycle event

`onAppear(preform:)` trigger actions when view appears.

`onDisappear(perform:)` trigger actions when view disappears.

`task(priority:_:)` trigger actions that execute asynchronously before the view appears on screen.
