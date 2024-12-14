# dotfiles

A way of living the term.

## Backup technique

I am using a git bare repository to backup my dotfiles as suggested by [DT on YouTube](https://www.youtube.com/watch?v=tBoLDpTWVOM), whom at the same time is using the following article from Atlassian

### Git bare repository setup

### 1. Create a bare repository

Create a bare repository wherever it suit you. I have it in a separe partition from the operative system (that is in fact where I place all my files). Use the following git command:

```
git init --bare $HOME/dotfiles
```

This will create a git repository which have objects we normally do not touch, but that make our repository database work (for example, HEAD is save here).

### 2. Link the bare repository with a worktree

Now we need the bare repository to (kind of) point to a specific folder, call the worktree (normally the worktree and the repository are in the same directory and you identified the repo by a hidden directory called .git).

Anyway, if none of that is clear, Just do the following:

```
echo 'alias dotf="/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME"' >> ~/.bashrc
```

Reload your shell as you like (close it and open if you do not know of any other way).

Finally, you are ready to use commands such as

```
dotf status
dotf add <dotfile>
dotf commit
dotf push origin master
```

### 3. Hide untracked files

```
dotf config --local status.showUntrackedFiles no
```

## How to Restore the Backup

TODO gozaimasu
