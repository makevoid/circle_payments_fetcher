require "yaml"
require "excon"
require "json"

DEBUG = false

CIRCLE_API_KEY = ENV["CIRCLE_API_KEY"]

# puts "CIRCLE_API_KEY #{CIRCLE_API_KEY}" if DEBUG

CIRCLE_API_HEADERS = {
  "Accept" => "application/json",
  "Authorization" => "Bearer #{CIRCLE_API_KEY}"
}

CIRCLE_PAYMENTS_IDS_FILE_PATH = "./data/circle_payment_ids.txt"

CIRLE_PAYMENTS_API_URL = "https://api.circle.com/v1/payments"

FAILED_REQUESTS = []

def read_all_payment_ids
  payment_ids = File.read CIRCLE_PAYMENTS_IDS_FILE_PATH
  payment_ids.strip!
  payment_ids = payment_ids.split "\n"
  payment_ids.map { |payment_id| payment_id.strip }
end

def get_payment(circle_payment_id:)
  url = "#{CIRLE_PAYMENTS_API_URL}/#{circle_payment_id}"
  begin
    res = Excon.get url, headers: CIRCLE_API_HEADERS
    res = res.body
    JSON.parse res
  rescue Exception => err
    FAILED_REQUESTS << circle_payment_id
    false
  end
end

def main
  output = []
  payment_ids = read_all_payment_ids
  payment_ids.each_with_index do |payment_id, idx|
    # next if idx > 2
    payment = get_payment circle_payment_id: payment_id
    if payment
      payment["payment_id"] = payment_id
      output << payment
    end
  end
  output = {
    circle_payments: output,
    failed_requests: FAILED_REQUESTS,
  }.to_yaml
  
  puts output
end

main
