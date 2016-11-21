require 'net/http'
require 'uri'
require 'json'

class Action
    @@stub_url  = 'http://192.168.1.20:8002';
    @@model_url = 'http://192.168.1.20:7306/risk/tags';
    def stop_stub
        system 'ps -ef | grep "Stub.rb"|awk -F" " \'{print $2}\'|xargs kill -9'
    end

    def start_stub(stub_data)
        start_status = system 'ps -ef | grep "Stub"|grep -v "grep"'
        print start_status
        if false == start_status
        then
            system 'nohup ruby Stub.rb &'
            sleep 1
            set_stub_data stub_data
        end
    end

    def get_check_data(request_data)
        url = URI.parse(@@model_url)
        req = Net::HTTP::Post.new(url,{'Content-Type' => 'application/json'})
        req.body = request_data.to_json
        res = Net::HTTP.new(url.hostname,url.port).start{|http| http.request(req)}
        return res.body
    end

    def set_stub_data(stub_data)
        url = URI.parse(@@stub_url)
        req = Net::HTTP::Post.new(url,{'Content-Type' => 'application/json'})
        req.body = stub_data.to_json
        Net::HTTP.new(url.hostname,url.port).start{|http| http.request(req)}
    end
end
