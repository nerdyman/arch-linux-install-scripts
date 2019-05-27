#!/bin/bash
# install useful atom plugins for web developers

function alis_atom_packages_web_developer_install {
	# shellcheck disable=SC2155
	local _script_name="$(basename "${BASH_SOURCE[0]}")"
	echo -e "[${_script_name}]\\n"

	local _default_user
	_default_user=$(whoami)

	if [[ $1 == "help" ]]; then
		echo "=> You can specify the following:"
		echo "==> User to run install as (default: ${_default_user})"
		echo "[${_script_name}]"
		exit 125
	fi

	local _user=${1:-$_default_user}

	local _install_targets="atom-typescript autocomplete-modules language-babel language-docker language-graphql linter linter-eslint linter-js-yaml linter-jsonlint  linter-sass-lint linter-stylelint linter-tslint linter-xmllint linter-js-yaml"

	echo "=> Install targets: ${_install_targets}"

	# shellcheck disable=SC2086
	sudo -H -u "$_user" apm install $_install_targets

	echo -e "\\n[${_script_name}] Done\\n"
}

alis_atom_packages_web_developer_install "$1"
