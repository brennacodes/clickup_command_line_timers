require_relative 'constants.rb'
require 'json'
require 'uri'
require 'net/http'
require 'openssl'

def msg_success(task, formatted)
  puts "Your timer for #{task} has been successfully #{formatted}ed."
end

def msg_error(task, formatted)
  puts "Something went wrong. Your timer for #{task} has NOT been successfully #{formatted}ed."
end

# Determines what message should be displayed in the console based on the resquest outcome
def complete_timer(action, outcome, task)
  formatted = action == "stop" ? action + "p" : action

  return msg_success(task, formatted) if outcome == true
  msg_error(task, formatted)
end

def complete_commit(body)
  puts "Operation completed. You can view results here: '/tmp/last_commit_response_body.txt'"

  # You will need to create these text files if you haven't already. 
  # See instructions in the Readme.md for more on this.
  File.open('/tmp/last_commit_time.txt', 'w') {|f| f.write(CURRENT_TIME.to_i.to_s)}
  File.open('/tmp/last_commit_response_body.txt', 'w') {|f| f.write(body) }
end

def check_action(action, outcome, body, task)
  if action == "commit"
    complete_commit(body)
  else
    complete_timer(action, outcome, task)
  end
end

# Here is where the request is made.
# The url is determined by the action passed through as an argument to this method.
def api_connection(action, request_body, task = nil)
  url = if action == "commit"
          BASE_URL
        else
          BASE_URL + "/" + action
        end

  url = URI(url)
  url.query = URI.encode_www_form(PARAMS)

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true

  post_request = Net::HTTP::Post.new(url)
  post_request['Content-Type'] = 'application/json'
  post_request['Authorization'] = CU_API_KEY
  post_request.body = request_body

  response = http.request(post_request)
  outcome = response.kind_of?(Net::HTTPSuccess)
  body = JSON.parse(response.read_body)

  # this will determine what to do depending on the outcome of the request
  check_action(action, outcome, body, task)
end
