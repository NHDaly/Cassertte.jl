module CassertteTests

using Cassertte
using Test

@testset "Basic assert" begin
    x = 3
    @test_throws AssertionError @Cassertte x == 5

    @test (@Cassertte x == 3) == nothing
end

@testset "Enable and disable the entire expression" begin
    function foo(a::Array)
        @Cassertte length(push!(a,5)) == 1
        return length(a)
    end

    @test foo([]) == 1
    @test_throws AssertionError foo([0])

    out = @noCassertte foo([0])
    @test out == 1
end

end  # module
