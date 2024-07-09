module DeepObjectServerTest
include("deep_server/src/deep.jl")
using .deep
using HTTP
using .deep: register
const server = Ref{Any}(nothing)
function find_pets_by_status(::HTTP.Messages.Request, param::deep.FindPetsByStatusStatusParameter)
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
DeepObjectServerTest.run_server()
