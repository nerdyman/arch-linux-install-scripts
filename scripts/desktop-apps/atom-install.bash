#!/bin/bash

function alis_atom_install {
	# shellcheck disable=SC2155
	local _script_name="$(basename "${BASH_SOURCE[0]}")"
	echo -e "[${_script_name}]\\n"

	local _default_user
	_default_user=$(whoami)
	local _default_locale="en_US"

	if [[ $1 == "help" ]]; then
		echo "=> You can specify the following:"
		echo "==> User to run install as (default: ${_default_user})"
		echo "==> Locale for spell checking (see hunspell-* in repos - default ${_default_locale})"
		echo "[${_script_name}]"
		exit 125
	fi

	local _user=${1:-$_default_user}
	local _locale=${2:-$_default_locale}

	local _install_targets="atom ctags trash-cli hunspell-${_locale}"

	echo "=> Install targets: ${_install_targets}"
	# shellcheck disable=SC2086
	sudo -H -u "$_user" trizen -S --noconfirm --needed --noedit $_install_targets

	local _apm_install_targets="atom-material-ui color-picker docblockr editorconfig enhanced-tabs file-icons git-blame git-time-machine highlight-bad-chars highlight-selected language-ini linter-markdown linter-shellcheck minimap pigments pinned-tabs pure-syntax sublime-style-column-selection tabs-to-spaces tree-view-git-status vim-modeline"

	echo "=> Installing atom packages: ${_apm_install_targets}"
	# shellcheck disable=SC2086
	sudo -H -u "$_user" apm install $_apm_install_targets

	echo "=> NOTE: You will need to execute atom with \`ELECTRON_TRASH=trash-cli atom\` to allow Atom to delete files"
	echo "   You may want to add the following to your shell .rc file \`export ELECTRON_TRASH=trash-cli\`"

	echo -e "\\n[${_script_name}] Done\\n"
}

alis_atom_install "$1"
