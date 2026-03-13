# ─── Powerlevel10k instant prompt ─────────────────────────────────────────────
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ─── Zinit ────────────────────────────────────────────────────────────────────
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git"
fi
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit



# ─── Plugins ──────────────────────────────────────────────────────────────────
zinit ice depth=1; zinit light romkatv/powerlevel10k

zinit wait lucid light-mode for \
    zsh-users/zsh-autosuggestions \
    zdharma-continuum/fast-syntax-highlighting \
    Aloxaf/fzf-tab

zinit snippet OMZ::lib/git.zsh
zinit snippet OMZ::plugins/git/git.plugin.zsh

# ─── Autosuggestions ──────────────────────────────────────────────────────────
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
bindkey '^ ' autosuggest-accept        # Ctrl+Space to accept
bindkey '^f' autosuggest-accept

# ─── History ──────────────────────────────────────────────────────────────────
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY

# ─── Terminal ─────────────────────────────────────────────────────────────────
export TERM=xterm-256color
set -o vi

# ─── XDG / Runtime ────────────────────────────────────────────────────────────
export XDG_RUNTIME_DIR=/run/user/$(id -u)
export PIPEWIRE_RUNTIME_DIR=$XDG_RUNTIME_DIR/pipewire
export DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus"

# ─── PATH ─────────────────────────────────────────────────────────────────────
[[ -d "$HOME/bin" ]]        && export PATH="$HOME/bin:$PATH"
[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/nvim/bin:$PATH"
export PATH="$PATH:$HOME/.lmstudio/bin"

# ─── CUDA ─────────────────────────────────────────────────────────────────────
export PATH="/usr/local/cuda-12.6/bin${PATH:+:${PATH}}"
export LD_LIBRARY_PATH="/usr/local/cuda-12.6/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}"

# ─── Rust / Cargo ─────────────────────────────────────────────────────────────
. "$HOME/.cargo/env"

# ─── Pyenv ────────────────────────────────────────────────────────────────────
export PYENV_ROOT="$HOME/.pyenv"
[[ -d "$PYENV_ROOT/bin" ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# ─── Conda ────────────────────────────────────────────────────────────────────
__conda_setup="$("$PYENV_ROOT/versions/miniconda3-latest/bin/conda" 'shell.zsh' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
elif [ -f "$PYENV_ROOT/versions/miniconda3-latest/etc/profile.d/conda.sh" ]; then
    . "$PYENV_ROOT/versions/miniconda3-latest/etc/profile.d/conda.sh"
else
    export PATH="$PYENV_ROOT/versions/miniconda3-latest/bin:$PATH"
fi
unset __conda_setup

# ─── NVM (lazy load) ──────────────────────────────────────────────────────────
export NVM_DIR="$HOME/.nvm"

nvm() {
    unset -f nvm node npm npx pnpm bun
    [ -s "$NVM_DIR/nvm.sh" ]          && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    nvm "$@"
}
node() { nvm; node "$@" }
npm()  { nvm; npm "$@" }
npx()  { nvm; npx "$@" }
pnpm() { nvm; pnpm "$@" }
bun()  { nvm; bun "$@" }

# ─── Bun ──────────────────────────────────────────────────────────────────────
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# ─── PNPM ─────────────────────────────────────────────────────────────────────
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# ─── Zoxide ───────────────────────────────────────────────────────────────────
eval "$(zoxide init zsh)"

# ─── Aliases ──────────────────────────────────────────────────────────────────
alias vim="nvim"
alias chrome="flatpak run com.google.Chrome"

# ─── Functions ────────────────────────────────────────────────────────────────
gh-switch() {
    gh auth switch "$@" && gh auth setup-git
}

# ─── Global .env ──────────────────────────────────────────────────────────────
[ -f ~/.env ] && export $(cat ~/.env | xargs)

# ─── Docker ───────────────────────────────────────────────────────────────────
export DOCKER_HOST=unix:///var/run/docker.sock

# ─── Powerlevel10k ────────────────────────────────────────────────────────────
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
