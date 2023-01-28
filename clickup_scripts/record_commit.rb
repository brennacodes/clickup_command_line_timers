## It is recommended to save this file in /usr/local/bin/*/record_commit.rb to make it globally available.
## The hook for this script is defined in usr/local/Cellar/git/2.38.0/share/git-core/templates/hooks/post-commit (depending on your OS)
## Once you've completed all of these steps, the `record_commit_timestamp` script will run automatically every time you make a successful commit in any Git repository on your system.

require 'json'
require 'date'
require_relative 'constants.rb'
require_relative 'api_call.rb'

# You may need to customize this method depending on how you format your commit messages.
# This script is set up process a commit message such as:
# "This is my commit message - CU-87654abc"
# It isolates the task ID (everything after "CU-" -> "87654abc") to be used in the request body.
def separate_task_id_and_message(commit_msg)
  task_idx = commit_msg.index(" - ")

  return { task_id: commit_msg[(task_idx + 6)..-1], msg: commit_msg[0..(task_idx - 1)] }
end

# Starts a new timer if the datetime is before today's date
def evaluate_start_time(task)
  @start_time = File.read('/tmp/last_commit_time.txt')
  converted = @start_time.to_datetime

  if converted < Date.today
    @start_time = DateTime.now.strftime('%Q')
  end
end

# If it's a new task, it will start a new timer for it, otherwise it will add time to the existing one.
def check_if_new(task)
  previous = File.read('/tmp/last_task_id.txt')

  if previous == task
    evaluate_start_time(task)
  else
    @start_time = DateTime.now.strftime('%Q')
    File.open('/tmp/last_task_id.txt', 'w') { |f| f.write(task) }
  end
end

def record_commit_timestamp(commit_message)
  info_hash = separate_task_id_and_message(commit_message)

  check_if_new(info_hash[:task_id])

  request_body = {
    description: info_hash[:msg],
    tags: [
      {
        name: 'commit',
        tag_bg: '#BF55EC',
        tag_fg: '#FFFFFF'
      }
    ],
    start: @start_time.to_i,
    billable: false,
    duration: CURRENT_TIME.to_i - @start_time.to_i,
    assignee: USER_ID,
    tid: info_hash[:task_id]
  }.to_json

  api_connection("commit", request_body)
end

commit_message = ARGV[0]

record_commit_timestamp(commit_message)
