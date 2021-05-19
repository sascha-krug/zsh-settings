# install zsh
# brew install zsh

# install oh-my-zsh
# https://github.com/ohmyzsh/ohmyzsh
# Change user name to our
export ZSH="/Users/krugs/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# install nerdfont
# cd ~/Library/Fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf

# install powerlevel9k
# https://github.com/Powerlevel9k/powerlevel9k/wiki/Install-Instructions#macos-with-homebrew
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_COLOR_SCHEME=light
POWERLEVEL9K_IGNORE_TERM_COLORS=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(ssh dir vcs newline status)
#POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(kubecontext)
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
# mabye cgange directory of powerlevel
source ~/powerlevel9k/powerlevel9k.zsh-theme

function f() { find . -iname "*$1*" ${@:2} }
function r() { grep "$1" ${@:2} -R . }

# install google-cloud-sdk
# brew install --cask google-cloud-sdk
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'
HOMEBREW_FOLDER="/usr/local/share"
# install zsh-autosuggestions
# brew install zsh-autosuggestions
# install zsh-syntax-highlightin
# brew install zsh-syntax-highlighting
source "$HOMEBREW_FOLDER/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$HOMEBREW_FOLDER/zsh-autosuggestions/zsh-autosuggestions.zsh"
if [ /usr/local/bin/kubectl ]; then source <(kubectl completion zsh); fi


if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

    autoload -Uz compinit
    compinit
fi

# install iterm-shell-integration
# curl -L https://iterm2.com/shell_integration/install_shell_integration.sh | bash
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true
current_kube_project() {
    echo $(kubectl config view -o=jsonpath='{.current-context}'|sed 's/gke_//g'|tr -s '_'|cut -d '_' -f 1)
}
current_kube_region() {
    echo $(kubectl config view -o=jsonpath='{.current-context}'|sed 's/gke_//g'|tr -s '_'|cut -d '_' -f 2)
}
current_kube_cluster() {
    echo $(kubectl config view -o=jsonpath='{.current-context}'|sed 's/gke_//g'|tr -s '_'|cut -d '_' -f 3)
}
iterm2_print_user_vars() {
  iterm2_set_user_var gitBranch $((git branch 2> /dev/null) | grep \* | cut -c3-)
  iterm2_set_user_var kubeProject $(current_kube_project)
  iterm2_set_user_var kubeRegion $(current_kube_region)
  iterm2_set_user_var kubeCluster $(current_kube_cluster)
}
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/node@12/bin:$PATH"
export PATH="/usr/local/opt/php@7.4/bin:$PATH"
export PATH="/usr/local/opt/php@7.3/sbin:$PATH"
export PATH="/usr/local/opt/mysql-client/bin:$PATH"

export VAULT_ADDR=https://vault.emma.empirietest.com/

autoload -Uz compinit
compinit

# for fuzzy search install fzf
# brew install fzf
# To install useful key bindings and fuzzy completion:
# $(brew --prefix)/opt/fzf/install
