require 'webrick'
require 'socket'
require 'json'

class Stub < WEBrick::HTTPServlet::AbstractServlet
    @@stub_data = Hash[]

    def do_POST(request, response)
        params_json = request.body
        obj = JSON.parse(params_json)
        params_hash = obj.to_hash
        if params_hash.has_key?("stub_data")
            then
            set_stub_data params_hash
        else
            params_hash = JSON.parse(params_hash["params"]).to_hash
            return_data = do_request params_hash
            response.status = 200 
            response.content_type = "text/plain"
            response.body = return_data.to_json
        end 
    end 
    
    def do_request(params)
        return @@stub_data[params["risk_type"]][params["risk_sub_type"]]
    end 

    def set_stub_data(params)
        params.delete("stub_data")
        @@stub_data = params;
    end
end

server = WEBrick::HTTPServer.new(:Port => 8002)
server.mount "/", Stub
trap("INT"){ server.shutdown }
server.start
