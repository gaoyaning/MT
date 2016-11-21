require '/home/gaoyaning/work/ruby/RunCase.rb'
run_case = RunCase.new
request_data = Hash[
    "scene" => "h_zm_score_credit"
]
stub_data = Hash[
    "zm.zm.data.content.score" => 750,
    "stub_data" => true
]

run_case.create_stub stub_data

request = run_case.create_request request_data
check_data = run_case.get_check_data request
run_case.destroy_stub
diff_data = Hash[
    "data.final_decision" => "Accept",
    "data.relation_id" => 236,
]
status = run_case.check_data diff_data, check_data
print status
print "\n"
