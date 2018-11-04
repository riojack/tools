#!/usr/bin/env bash

is_gitted_directory_tree() {
	$(git rev-parse --show-toplevel &> /dev/null)
	local git_toplevel_ret=$?

	if [ $git_toplevel_ret -eq 0 ];
		then
			echo $(git rev-parse --show-toplevel)
		else
			echo ""
	fi
}

dir_me_up() {
	local directory_name="${PWD##*/}"

	if [ ${#directory_name} -gt 5 ];
		then
			echo "${directory_name:0:5}..."
		else
			echo "${directory_name:0}"
	fi
}

branch_me_up() {
	if [ -n "$(is_gitted_directory_tree)" ];
		then
			printf ' \033[1;33m(%s)\033[0m' $(git rev-parse --abbrev-ref HEAD)
	fi
}

node_me_up() {
	if [[ -n "$(is_gitted_directory_tree)" && -e "$(git rev-parse --show-toplevel)/package.json" ]];
		then
			printf ' \033[38;5;106m(Node %s)\033[0m' $(node -v)
	fi
}

export PS1='\[\e[32m\]`echo "${PWD%/*}" | sed -e "s;\(/.\)[^/]*;\1;g"`/$(dir_me_up)\[\e[m\]$(branch_me_up)$(node_me_up) \$ '
