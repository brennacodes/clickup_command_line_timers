#!/usr/bin/env zsh
ruby /usr/local/bin/record_commit_timestamp.rb "$(git log -1 --pretty=%B)"

############# DO NOT COPY THIS LINE OR ANYTHING BELOW INTO YOUR FINAL FILE ##############
# Copy and paste lines 1 & 2 into a file named `post-commit` (NO EXTENSION) inside of your 
# `git -> templates -> git-hooks` directory
# Your filepath might look slightly different depending on your system and how you installed git,
# but as long as it is in your system's git hooks directory, it should work.
