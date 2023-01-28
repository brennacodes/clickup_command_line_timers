require 'date'

PARAMS = {
  team_id: <YOUR_TEAM_ID>,
  custom_task_ids: false
}

BASE_URL = "https://api.clickup.com/api/v2/team/#{PARAMS[:team_id]}/time_entries"
CU_API_KEY = <YOUR_API_KEY>

USER_ID = <YOUR_CLICKUP_USER_ID>

CURRENT_TIME = DateTime.now.strftime('%Q')

# This is just for command line output formatting. Feel free to go nuts.
LONG_LINE = "--------------------------------------------------------------------------------------"
