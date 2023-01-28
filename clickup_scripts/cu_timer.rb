require 'date'
require 'uri'
require 'json'
require 'openssl'
require 'net/http'
require_relative 'constants.rb'
require_relative 'cu_api_call.rb'

# commands:
# `cu start <tag> <note> <tid>`
# `cu stop <tag> <note> <tid>`

@action = ARGV[0]
@tag = ARGV[1] if ARGV[1]
@note = ARGV[2] if ARGV[2]
@tid = ARGV[3] if ARGV[3]

# This sets the Task ID to be used later. 
# It should be only numbers and letters - no symbols, or spaces (omit any prepended symbols as well as `CU`)
# You can change the tags to anything you need (eg. 'emails', 'research', etc.)
# Just make sure you put the corresponding task id under the tag
TASK_ID = case @tag
          when "meeting"
            "<YOUR_MEETING_TASK_ID>"
          when "routine"
            "<YOUR_OTHER_TASK_ID"
          else 
            "#{@tid}" if @tid
          end

# This sets the request body for the api call
# If the action is `stop`, there is no request body
def timer
  request_body = {
    description: "#{@tag}: #{@note}",
    tags: [{name: "#{@tag}"}],
    tid: "#{TASK_ID}",
    billable: false
  }.to_json

  request_body = "" if @action == "stop"

  api_connection(@action, request_body, @tag)
end

timer
