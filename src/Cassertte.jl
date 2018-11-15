module Cassertte

export @Cassertte, @noCassertte

using Toggles

macro Cassertte(expr)
    quote
        Toggles.@toggleable(@assert($(esc(expr)), $(string(expr))), CassertteSwitch())
    end
end

struct CassertteSwitch end

macro noCassertte(expr)
    @assert expr.head == :call
    quote Toggles.@toggle(CassertteSwitch(), $(esc(expr))) end
end

end
