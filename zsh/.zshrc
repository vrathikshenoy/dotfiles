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

zinit light zsh-users/zsh-autosuggestions

# Defer heavier plugins that aren't needed at first keystroke
zinit wait lucid light-mode for \
    zdharma-continuum/fast-syntax-highlighting \
    Aloxaf/fzf-tab

# Defer OMZ git snippets (not needed at first keystroke)
zinit wait lucid for \
    OMZ::lib/git.zsh \
    OMZ::plugins/git/git.plugin.zsh

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
export PATH="$HOME/.cargo/bin:$PATH"

# ─── Pyenv (lazy load) ────────────────────────────────────────────────────────
export PYENV_ROOT="$HOME/.pyenv"
[[ -d "$PYENV_ROOT/bin" ]] && export PATH="$PYENV_ROOT/bin:$PATH"
pyenv() {
    unset -f pyenv python python3 pip pip3
    eval "$(command pyenv init -)"
    pyenv "$@"
}
python()  { pyenv; python "$@" }
python3() { pyenv; python3 "$@" }
pip()     { pyenv; pip "$@" }
pip3()    { pyenv; pip3 "$@" }

# ─── Conda (lazy load) ────────────────────────────────────────────────────────
conda() {
    unset -f conda
    source "$PYENV_ROOT/versions/miniconda3-latest/etc/profile.d/conda.sh"
    conda "$@"
}

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

# ─── Zoxide (cached) ──────────────────────────────────────────────────────────
# Regenerate with: zoxide init zsh > ~/dotfiles/zsh/.zoxide.zsh
source ~/dotfiles/zsh/.zoxide.zsh

# ─── Aliases ──────────────────────────────────────────────────────────────────
alias vim="nvim"
alias chrome="flatpak run com.google.Chrome"

# ─── Functions ────────────────────────────────────────────────────────────────
gh-switch() {
    gh auth switch "$@" && gh auth setup-git
}

# ─── Global .env ──────────────────────────────────────────────────────────────
if [ -f ~/.env ]; then
  set -a
  source ~/.env
  set +a
fi

# ─── Docker ───────────────────────────────────────────────────────────────────
export DOCKER_HOST=unix:///var/run/docker.sock

# ─── Powerlevel10k ────────────────────────────────────────────────────────────
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ─── Compile zshrc for faster sourcing ────────────────────────────────────────
{ [[ ~/.zshrc -nt ~/.zshrc.zwc ]] && zcompile ~/.zshrc; } 2>/dev/null
true  # ensure clean exit status for prompt
