#!/bin/bash

# Check if a directory path is provided, otherwise use the current directory
dir="${1:-$(pwd)}"

# Start a new tmux session detached
tmux new-session -d -s mySession

# Split the window into two horizontal panes, with the right pane being 50% of the screen width
tmux split-window -h -p 50

# Open Vim Explore in the left pane with the specified directory
tmux send-keys -t mySession:0.0 "vim -c 'Explore $dir'" C-m

# Split the right pane vertically by 30%
tmux split-window -v -p 30

# Attach to the session
tmux attach-session -t mySession
set mouse on