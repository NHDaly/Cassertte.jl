module Cassertte

export @Cassertte, @withCassertte

using Toggles

"""
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
"""
macro Cassertte(expr)
    quote
        Toggles.@toggleable(nothing, CassertteSwitch(), @assert($(esc(expr)), $(string(expr))))
    end
end

struct CassertteSwitch end

"""
    @withCassertte foo(x,y,z)
Call a function with @Cassertte assertions enabled. Note that this causes the entire
expression inside any @Cassertte statements to be evaluated.
 """
macro withCassertte(expr)
    quote Toggles.@toggle(CassertteSwitch(), $(esc(expr))) end
end

end
