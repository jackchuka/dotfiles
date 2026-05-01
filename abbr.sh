# one-time zsh-abbr setup — needs zsh with zsh-abbr loaded
echo "Setting up zsh abbreviations..."

zsh -c '
source "$(brew --prefix)/share/zsh-abbr/zsh-abbr.zsh"

abbr -f yolo="claude --dangerously-skip-permissions"
abbr -f t="tree -C"

abbr -f gp="git pull"
abbr -f gpo="git pb"
abbr -f gm="git checkout \"\$(git symbolic-ref refs/remotes/origin/HEAD | cut -d\"/\" -f4)\""
abbr -f gamend="git add . && git commit --amend --no-edit"
abbr -f gs="git status"
abbr -f gd="git diff --color-words"

abbr -f k="kubectl"
abbr -f kg="kubectl get"
abbr -f kgpo="kubectl get pod"
abbr -f kl="kubetail"
abbr -f kc="kubectx"
abbr -f kn="kubens"
abbr -f k9="k9s --readonly"
'
