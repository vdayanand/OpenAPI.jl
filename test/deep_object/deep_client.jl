module DeepObjectClientTest
include("deep_client/src/deep.jl")
using .deep
using .deep.OpenAPI.Clients: Client
using .deep: FindPetsByStatusStatusParameter

function test()
    client = Client("localhost:8081")
    api = deep.PetApi(client)
    unsold = FindPetsByStatusStatusParameter("key", ["available", "pending"])
    _, http_resp = find_pets_by_status(api, unsold)
    @info http_resp
end

end # module DeepObjectClientTest
