# Cassertte.jl

Cassertte is an Assertion library, providing `@Cassertte`: an `@assert` replacement that allows eliminating the entire expression in the assertion body.

This is similar to the way the C/C++ `<cassert>` library disables the entire `assert(expression)` when `#define NDEBUG` is set.

I've currently opted for @Cassertte statements to be disabled by default, only evaluating their argument expressions when called via @withCassertte.

Cassertte is built using [`Casette.jl`](https://github.com/jrevels/Cassette.jl), and is implemented by recompiling your provided function with the `@Cassertte expr` statements re-injected.

````julia
    @Cassertte length(unique(elements)) == 10

An @assert replacement that only evaluates its argument expr when called via @withCassertte.

@Cassertte is disabled by default, and can be enabled in calling code via @withCassertte.
Importantly, the _entire expression_ is eliminated. This frees you to check expensive
calculations in your assert statement. But of course, it means that you should never
depend on the side effects of an expression within a @Cassertte.

To run your code with all @Cassertte statements enabled, use @withCassertte:
```
    @withCassertte foo(1,2)
```
````
