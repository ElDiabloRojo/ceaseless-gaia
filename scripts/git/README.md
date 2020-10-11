# Git Scripts

## Pre-push

### Setup

Configure the pre-push script by creating symbolic link in the git hooks dir. 

  Execute from project root:

```
  ln -s ./scripts/git/pre-push ./.git/hooks/pre-push
```

[TODO: create developer setup tools to implement this hook, https://linear.app/holden-apy/issue/HOL-25/install-git-hooks-automatically]