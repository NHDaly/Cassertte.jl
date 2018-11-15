module CassertteTests

using Cassertte

using Test

@testset "Basic assert" begin
    x = 3
    # The macro does nothing by default.
    @test (@Cassertte x == 3) == nothing
    @test (@Cassertte x == 5) == nothing

    # When enabled via @withCassertte, the macro is identical to assert
    @test (@assert x == 3) == nothing
    @test (@withCassertte @Cassertte x == 3) == nothing
    @test_throws AssertionError @assert x == 5
    @test_throws AssertionError @withCassertte @Cassertte x == 5
end

@testset "Enable and disable the entire expression" begin
    function foo(a::Array)
        @Cassertte length(push!(a,5)) == 1
        return length(a)
    end

    out = foo([0])
    @test out == 1

    # When running with Cassertte enabled, the array gets modified
    @test (@withCassertte foo([])) == 1
    @test_throws AssertionError @withCassertte foo([0])
end

end  # module
