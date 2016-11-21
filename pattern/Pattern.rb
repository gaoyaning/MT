require 'json'

class Pattern
    @@stub_data = Hash[
        "zm" => Hash[
            "zm" => Hash["data" => Hash["content" => Hash["score" => 650]],"status" => 1],
            "identify" => Hash[
                "data" => Hash[
                    "content" => Hash[
                        "iVSVerifyResult" => Hash[
                            "resultMap" => Hash[
                                "infocode_result_list" => "ADDR_Mismatch",
                            ],  
                            "score" => 90, 
                        ]   
                    ]   
                ],
                "status" => 1
            ],
            "riskinfo" => Hash["data" => Hash["content" => Hash["isRisk" => "F"]], "status" => 1],
        ],  
        "tongdun" => Hash[
            "tongdun" => Hash[ 
                "data" => Hash[
                    "final_decision" => "Accept",
                    "final_score" => 0,
                ],
                "status" => 1
            ],
        ],  
        "black" => Hash[
            "detect" => Hash["data" => Hash["is_hit" => 0],"status" => 1],
        ],
    ]
    @@request_json = '{"scene":"h_zm_score_credit","user_info":{"user_id":"4054146","name":"庞龙","user_name":"庞龙","mobile":"18860009195","id_number":"331023198708083154","customer_id":"268813897533674036534166269","user_status":{"alipay_user_id":"2088712514113995","gender":"m","user_status":"T","user_type_value":"2","is_id_auth":"T","is_mobile_auth":"T","is_bank_auth":"T","is_student_certified":"F","is_certify_grade_a":"T","is_certified":"T","is_licence_auth":"F","cert_type_value":"0","account_id":"11682645","order_num":0,"hasPaid":0},"ip_address":"117.136.75.84","is_test":0,"registed_at":"2016-02-2202:46:33","user_type":"normal","order_type":"qudian","iou_limit":0,"alipay_user_id":"2088712514113995","token_id":"6d3712cf580d59fe07d85e93d9419bc9","bqs_token_key":"3005ecdef7f6f4176bbb0caefff4eb24","latitude":"24.532611","longitude":"118.157503","user_address":[{"prov":"福建省","city":"厦门市","area":"湖里区","mobile":"18860009195","name":"庞龙","address":"火炬高技术开发区安岭路989号>裕隆国际大厦707室"}]},"partner_id":"10003","microtime":"0.783923001478677845","account_id":10546073}'

    def set_stub_data(data)
        data.each {|key_str, value|
            key_arr = key_str.split('.')
            recursive_set_stub_data @@stub_data, key_arr, value
        }
        return @@stub_data
    end

    def set_request_data(data)
        request_hash_data = JSON.parse(@@request_json).to_hash
        data.each {|key_str, value|
            key_arr = key_str.split('.')
            recursive_set_stub_data request_hash_data, key_arr, value
        }
        return request_hash_data
    end

    def recursive_check_data(check_data, arr_data, value)
        key = arr_data.shift
        if true == arr_data.empty?
        then
            return true
        end
        if true != check_data.has_key?(key)
        then
            return false
        end
        recursive_check_data check_data[key], arr_data, value
    end

    def recursive_set_stub_data(hash_stub_data, arr_data, value)
        key = arr_data.shift
        if true == arr_data.empty?
        then
            hash_stub_data[key] = value
            return
        end
        if true != hash_stub_data.has_key?(key)
            then
            hash_stub_data[key] = Hash.new
        end
        recursive_set_stub_data hash_stub_data[key], arr_data, value
    end
end
