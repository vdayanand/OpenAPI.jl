@testset "Test deep_serialize_queryparams" begin
    @testset "Single level object" begin
        dict = Dict("key1" => "value1", "key2" => "value2")
        expected = "key1=value1&key2=value2"
        @test deep_serialize_queryparams(dict) == expected
    end

    @testset "Nested object" begin
        dict = Dict("outer" => Dict("inner" => "value"))
        expected = "outer[inner]=value"
        @test deep_serialize_queryparams(dict) == expected
    end

    @testset "Deeply nested object" begin
        dict = Dict("a" => Dict("b" => Dict("c" => Dict("d" => "value"))))
        expected = "a[b][c][d]=value"
        @test deep_serialize_queryparams(dict) == expected
    end

    @testset "Multiple nested objects" begin
        dict = Dict("a" => Dict("b" => "value1", "c" => "value2"))
        expected = "a[b]=value1&a[c]=value2"
        @test deep_serialize_queryparams(dict) == expected
    end

    @testset "Dictionary represented array" begin
        dict = Dict("a" => ["value1", "value2"])
        expected = "a[0]=value1&a[1]=value2"
        @test deep_serialize_queryparams(dict) == expected
    end

    @testset "Mixed structure" begin
        dict = Dict("a" => Dict("b" => "value1", "c" => ["value2", "value3"]))
        expected = "a[b]=value1&a[c][0]=value2&a[c][1]=value3"
        @test deep_serialize_queryparams(dict) == expected
    end

    @testset "Blank values" begin
        dict = Dict("a" => Dict("b" => "", "c" => ""))
        expected = "a[b]=&a[c]="
        @test deep_serialize_queryparams(dict) == expected
    end

    @testset "Encoded characters" begin
        dict = Dict("a" => Dict("b" => "value with spaces"))
        expected = "a[b]=value with spaces"
        @test deep_serialize_queryparams(dict) == expected
    end

    @testset "Complex nested structure" begin
        dict = Dict("a" => Dict("b" => Dict("c" => Dict("d" => "value1", "e" => "value2")), "f" => "value3"))
        expected = "a[b][c][d]=value1&a[b][c][e]=value2&a[f]=value3"
        @test deep_serialize_queryparams(dict) == expected
    end
end
