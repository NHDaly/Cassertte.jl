module Cassertte

export @Cassertte, @withCassertte

using Toggles

macro Cassertte(expr)
    quote
        Toggles.@toggleable(nothing, CassertteSwitch(), @assert($(esc(expr)), $(string(expr))))
    end
end

struct CassertteSwitch end

macro withCassertte(expr)
    quote Toggles.@toggle(CassertteSwitch(), $(esc(expr))) end
end

end
