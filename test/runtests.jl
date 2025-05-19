using PhilipsWorkspace
using Test


@testset "PhilipsWorkspace.jl" begin
    # Write your tests here.
end

@testset "_recursive_only" begin
    @test PhilipsWorkspace._recursive_only(1) == 1
    @test PhilipsWorkspace._recursive_only([1]) == 1
    @test PhilipsWorkspace._recursive_only([[1]]) == 1
    @test PhilipsWorkspace._recursive_only([[[1]]]) == 1

    @test PhilipsWorkspace._recursive_only([1, 2, 3]) == [1, 2, 3]
    @test PhilipsWorkspace._recursive_only([[1, 2, 3]]) == [1, 2, 3]
    @test PhilipsWorkspace._recursive_only([[1], [2], [3]]) == [1, 2, 3]

    @test PhilipsWorkspace._recursive_only("a") == "a"
    @test PhilipsWorkspace._recursive_only(["a"]) == "a"
    @test PhilipsWorkspace._recursive_only([["a"]]) == "a"
    @test PhilipsWorkspace._recursive_only([[["a"]]]) == "a"
end
