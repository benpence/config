
# Branch

    # Move uncommitted changes to branch/new branch
    git checkout <branch>
    git checkout -b <branch>

    # Rename <old_branch>
    git branch -m <old_branch> <new_branch>
    git branch -M <old_branch> <new_branch> # Replaces <new_branch>

    # Delete <branch>
    git branch -d <branch>

# Add

    # Interactively use the add command
    git add -i

    # Add in patch mode. Stage diff hunks independently
    git add -p

# Stash

    # Push all tracked changes onto stack
    git stash

    # Push all tracked and untracked changes onto stack
    git stash -u

    # Apply changes from stash
    git stash apply pop         # first and drop first on success
    git stash apply stash@{0}   # first
    git stash apply stash@{1}   # second

# Rebase

    # Apply changes in <topic_branch> onto head of <base_branch> and fastforward
    git rebase <base_branch> <topic_branch>
    git checkout <base_branch>
    git merge <topic_branch>

    # Retroactively edit commit history interactively after <commit>
    git rebase -i <commit>

# Diff
    
    # Compare current unstaged changes
    git diff                                # To the HEAD
    git diff HEAD                           # ...
    git diff HEAD~<number>                  # To <number> commits before HEAD

    # Compare changes
    git diff HEAD           HEAD~<number>   
    git diff HEAD~<number>  HEAD~<number>
    git diff <first_commit> <second_commit>
    git diff <first_commit  HEAD~<number>
