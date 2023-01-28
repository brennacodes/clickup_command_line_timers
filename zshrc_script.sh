# The script here is to create the alias that you can call from your command line.
# It goes inside of your ~/.zshrc file.

# Alias for ClickUp timer start/end:
alias cu="ruby /usr/local/bin/cu_command_line_scripts/cu_timer.rb $1 $2"

# Call the alias as `cu start meeting 'Sales meeting with Wally World'`, it will execute the command `ruby /usr/local/bin/cu_api_call.rb start meeting 'Sales meeting with Wally World'`
# You will need to restart your terminal or run source ~/.zshrc for the alias to take effect.
