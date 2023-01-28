# ClickUp Timer Command Line Scripts
Start and Stop your ClickUp timers with a simple command. Use Git hooks to automatically add time to a timer as a successful commit is posted.

## How to use the command line to start and stop a timer for a task...
1. Fork or clone this repo.
2. Save the `clickup_scripts` folder inside of the `usr/local/bin` directory (or similar depending on your OS)
3. Copy the `zsh_script` into your `~/.zshrc` file (or bash, fsh, etc. - depending on your system it may need to be adjusted slightly).
4. Restart your terminal or the command `source ~/.zshrc`.

#### Now...
Look over the files in the `clickup_scripts` directory and update information as needed.  
For example, you probably want to update the `TEAM_ID`, `USER_ID`, and `API_KEY`, though there may be other areas that you will want to customize (such as the api endpoints depending on your desired use).  
   
#### To Start and Stop a Timer...
##### To start a timer:
Run the command `cu start <tag> <note>` from your terminal.  
You should receive a message indicating whether the timer succesfully started, or whether an error was encountered.  
  
##### To stop a timer:
Run the command `cu stop <tag> <not>` from your terminal.  
You should receive a message indicating whether the timer succesfully stopped, or whether an error was encountered.  

## How To Create a Global Post-Commit Git Hook

Some initial notes before you dive in...
- It is recommended to save the ruby script in `/usr/local/bin/clickup_scripts/record_commit.rb` to make it globally available.  
- The hook is defined in `usr/local/Cellar/git/2.38.0/share/git-core/templates/hooks/post-commit` (NOTE: this file should have no file extension)  
- Once you've completed all of these steps below, the `record_commit` script will run automatically every time you make a successful commit in any Git repository on your system.  
- The script was created to use commits that have commit messages appended with a special "task_id" to record time entries for work, but you can update the script to use it for whatever your needs are. 


To set up the post-commit hook, which is a script that runs after a successful commit, you should locate the `.git/hooks` directory on your system.  
On Linux and macOS, this directory is typically located at `~/.config/git/hooks`. On Windows, it is located at `C:\Program Files\Git\mingw64\share\git-core\templates\hooks`  
  
Create a new file called `post-commit` in this directory.   
  
The post-commit script should contain the following line, which runs the script you just created and passes the commit message as an argument to the script.:   
`ruby /usr/local/bin/clickup_scripts/record_commit.rb "$(git log -1 --pretty=%B)"`  
  
This script uses the git log command to get the commit message, and it passes the commit message to the `record_commit.rb` script as an argument.  
  
It is important to note that this directory may not exist by default, so you may need to create it if it does not exist.  
The directions here set it up as a global hook, which will be applied to every repository on your machine. You can find the global hooks in your `$(prefix)/share/git-core/templates/hooks` directory.
The actual directory may vary depending on your environment.  
If yours is different, you can start to locate the directory by running the following command:  
`git --exec-path` -or- `find template/hooks`. 
  
*Please note that if you have already created a post-commit hook in a specific repository, the global one will not override it.*
  
You should make sure that the post-commit script has permission to execute by running the following command once the above steps are complete:  
`chmod +x post-commit`

#### NOTE: Make sure you run the `chmod +x` command for any additional files you created in the script (such as the .txt files).

Re-initialize git in the repository you want to use the hook in.  
`git init`

### NOTE: Keep in mind that if you change the script, you need to repeat these steps again to propagate the changes.


# Feedback? Suggestions? Questions? Praise?
#### *[Send 'em on over!](mailto:brennacodes@gmail.com)*
