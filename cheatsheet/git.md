# Branch

    # Move uncommitted changes to branch/new branch
    git checkout <branch>
    git checkout -b <branch>

    # Rename <old_branch>
    git branch -m <old_branch> <new_branch>
    git branch -M <old_branch> <new_branch> # Replaces <new_branch>

    # Delete <branch>
    git branch -d <branch>

# Stash

    # Push all tracked changes onto stack
    git stash

    # Push all tracked and untracked changes onto stack
    git stash -u

    # Apply changes from stash
    git stash apply pop         # first
    git stash apply stash@{0}   # first
    git stash apply stash@{1}   # second

# Rebase

    # Apply changes in <topic_branch> onto head of <base_branch> and fastforward
    git rebase <base_branch> <topic_branch>
    git checkout <base_branch>
    git merge <topic_branch>

    # Retroactively edit commit history interactively after <commit>
    git rebase -i <commit>
