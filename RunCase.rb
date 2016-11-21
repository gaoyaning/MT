require '/home/gaoyaning/work/ruby/Action.rb'
require '/home/gaoyaning/work/ruby/Pattern.rb'
require 'json'
class RunCase
    def create_stub(stub_data)
        action = Action.new
        pattern = Pattern.new
        stub_data = pattern.set_stub_data stub_data
        action.start_stub stub_data
    end

    def get_check_data(request_data)
        action = Action.new
        json_data = action.get_check_data request_data
        return_data = JSON.parse(json_data).to_hash
        return_data["data"] = JSON.parse(return_data["data"]).to_hash
        return return_data
    end

    def destroy_stub()
        action = Action.new
        action.stop_stub
    end

    def create_request(request_data)
        pattern = Pattern.new
        stub_data = pattern.set_request_data request_data
        return Hash[
            "partner_id" => "110001",
            "params" => stub_data.to_json,
            "version" => "1.0",
            "ts" => 1479435821,
            "sign" => "XWQGZ4z62MSrg+IbufB0jUeOHGyvLRjLwCSsoVCdA8xo8zWLT9rsv/+K678g7/negE76yAwGQUhPAjVflJ94asx1f91Z2qJ4XhwMqx9pWFcMMaV9djla55OAumLatflfyFNR05eachUctdaGUySiLYzTnyPqGFmr+sIa/sY59xQ=",
        ]
    end

    def check_data(diff_data, check_data)
        pattern = Pattern.new
        check_result = Hash[]
        status = true
        diff_data.each{|key_str, value|
            key_arr = key_str.split('.')
            check_result[key_str] = pattern.recursive_check_data check_data, key_arr, value
            if false == check_result[key_str]
                then
                status = false
            end
        }
        print check_result.to_json + "\n"
        return status
    end
end

=begin
run_case = RunCase.new
data = Hash[
    "zm.zm.data.content.score" => 750,
    "stub_data" => true
]

run_case.create_stub data
sleep 10
run_case.destroy_stub
=end

=begin
run_case = RunCase.new
request_data = Hash[
    "scene" => "h_zm_score_credit"
]
request = run_case.create_request request_data
data = run_case.get_check_data request
print data.to_json
=end
