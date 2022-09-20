export PATH="/home/iiro/.emacs.d/bin/:/home/iiro/.pyenv/bin:/home/iiro/.cargo/bin:/home/iiro/.local/bin:/home/iiro/bin:$PATH"

# disable welcome message
set fish_greeting

# ghcup-env
set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME
test -f /home/iiro/.ghcup/env ; and set -gx PATH $HOME/.cabal/bin /home/iiro/.ghcup/bin $PATH

# opam configuration
source /home/iiro/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

# omf bobthefish theme
set -g theme_color_scheme nord
