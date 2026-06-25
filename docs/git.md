# Git Commands Reference

## Submodules

### Add a submodule
```bash
git submodule add https://github.com/username/other-repo.git path/to/subfolder
git commit -m "Added other-repo as submodule"
```

### Clone a repo with its submodules
```bash
git clone --recurse-submodules https://github.com/username/main-repo.git
```

### Initialize submodules after cloning without them
```bash
git submodule update --init --recursive
```

### Keep submodules synced and updated
```bash
git submodule update --remote --merge
```

### Push changes inside a submodule
```bash
cd path/to/subfolder
git add .
git commit -m "Update submodule content"
git push
```

---

## Subtrees (Alternative to Submodules)

> Use submodules when you want repos separate but linked. Use subtrees when you want everything in one repo.

### Add another repo as a subtree
```bash
git subtree add --prefix=path/to/subfolder https://github.com/username/other-repo.git main
```

### Pull updates from the subtree remote
```bash
git subtree pull --prefix=path/to/subfolder https://github.com/username/other-repo.git main
```

---

## GitHub SSH Setup

### Generate SSH key and add to SSH agent
```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
eval "$(ssh-agent -s)"
ssh-add
```

### Display your public key (copy and paste into GitHub → Settings → SSH Keys)
```bash
cat ~/.ssh/id_rsa.pub
```

### Test SSH connection to GitHub
```bash
ssh -T git@github.com
```

---

## Branching

```bash
git branch                               # list local branches
git branch -a                            # list all branches (including remote)
git checkout -b feature/my-feature       # create and switch to new branch
git switch main                          # switch branch (modern syntax)
git branch -d branch-name                # delete local branch
git branch -D branch-name                # force delete local branch
git push origin --delete branch-name     # delete remote branch
```

---

## Staging & Committing

```bash
git status                               # show working tree status
git diff                                 # unstaged changes
git diff --staged                        # staged changes
git add file.txt                         # stage a file
git add .                                # stage all changes
git add -p                               # interactively stage chunks
git commit -m "commit message"           # commit
git commit --amend --no-edit             # add changes to last commit
```

---

## Stashing

```bash
git stash                                # stash current changes
git stash pop                            # apply most recent stash and remove it
git stash list                           # list all stashes
git stash apply stash@{0}               # apply specific stash without removing
git stash drop stash@{0}                # delete specific stash
git stash clear                          # remove all stashes
git stash push -m "my description"       # stash with a description
```

---

## Undoing Changes

```bash
git restore file.txt                     # discard uncommitted changes in a file
git restore --staged file.txt            # unstage a file (keep changes)
git reset HEAD~1                         # undo last commit, keep changes staged
git reset --soft HEAD~1                  # undo last commit, keep changes in working dir
git reset --hard HEAD~1                  # undo last commit and discard changes
git revert <commit-hash>                 # create new commit that undoes a previous one
```

---

## Remote

```bash
git remote -v                            # show remotes
git remote add origin https://...        # add remote
git fetch --all                          # fetch all remotes
git pull origin main                     # pull from main
git push -u origin feature/my-feature    # push new branch and set upstream
git push --force-with-lease              # safer force push
```

---

## Log & History

```bash
git log --oneline --graph --all          # visual branch log
git log --oneline -20                    # last 20 commits
git log --author="Name"                  # commits by author
git log -- path/to/file                  # history of a specific file
git blame file.txt                       # who changed each line
git show <commit-hash>                   # show a specific commit
git shortlog -sn                         # commit count by author
```

---

## Tags

```bash
git tag                                  # list tags
git tag v1.0.0                           # create lightweight tag
git tag -a v1.0.0 -m "Release v1.0.0"   # create annotated tag
git push origin v1.0.0                   # push a tag
git push origin --tags                   # push all tags
git tag -d v1.0.0                        # delete local tag
git push origin --delete v1.0.0          # delete remote tag
```

---

## Useful Global Config Aliases

```bash
git config --global alias.lg "log --oneline --graph --all --decorate"
git config --global alias.st "status -s"
git config --global alias.co "checkout"
git config --global alias.br "branch"
git config --global alias.unstage "restore --staged"
git config --global pull.rebase true
```

---

## Useful One-Liners

```bash
# Delete all local branches already merged to main
git branch --merged main | grep -v "main\|master" | xargs git branch -d

# Show files changed in last commit
git diff HEAD~1 HEAD --name-only

# Search for a string in all commits
git log -S "search_string" --oneline

# Cherry-pick a commit from another branch
git cherry-pick <commit-hash>

# Clean untracked files (dry run first)
git clean -n        # preview
git clean -fd       # delete untracked files and dirs
```
