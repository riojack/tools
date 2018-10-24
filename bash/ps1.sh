#!/usr/bin/env bash

dir_me_up() {
	local directory_name="${PWD##*/}"

	echo "${directory_name:0:5}..."
}

branch_me_up() {
	if [ -e ".git" ];
		then
			printf ' \033[1;33m(%s)\033[0m' $(git rev-parse --abbrev-ref HEAD)

	fi
}

node_me_up() {
	if [ -e package.json ];
		then
			printf ' \033[38;5;106m(Node %s)\033[0m' $(node -v)
	fi
}

export PS1='\[\e[32m\]`echo "${PWD%/*}" | sed -e "s;\(/.\)[^/]*;\1;g"`/$(dir_me_up)\[\e[m\]$(branch_me_up)$(node_me_up) \$ '
