module DeepServerTest
include("DeepServer/src/DeepServer.jl")
using .DeepServer
using HTTP
using .DeepServer: register

const server = Ref{Any}(nothing)

function find_pets_by_status(::HTTP.Messages.Request, param::DeepServer.FindPetsByStatusStatusParameter)
    return param
end

function run_server(port=8081)
    try
        router = HTTP.Router()
        router = register(router, @__MODULE__)
        server[] = HTTP.serve!(router, port)
        wait(server[])
    catch ex
        @error("Server error", exception=(ex, catch_backtrace()))
    end
end

end # module DeepObjectClientTest
DeepServerTest.run_server()
