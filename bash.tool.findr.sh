#!/bin/sh
# Current Update: 03.30.2018
# Previous Update: 07.11.2017

# -- script for finding files on remote servers that may not be able to install python or custom tools -- #
function findr() {
	
	# local regex_pattern="${1}"
	local regex_match;
	local folder_path;
	local current_path=$(pwd);
	
	# local error_message=$(cat <<-EndOfMessage
	# 	
	# 	Enter the amount of results to return
	# 	
	# 	--results | -r
	# 	
	# 	EndOfMessage);

	#if [ ! -z "$1" ];
	#if [ "${1}" != "-r" ];
	
	if [ -z "${1}" ] ; then
		echo 'error: no value entered'
	
	elif  [ "${1}" != "-r" ];
	then
		
		local number_of_results="5"
		local regex_pattern="${1}"
		
		# -- return the results from regex match -- #
				
		regex_match=$( \
		find . -type d -name "*" -maxdepth 1 -exec ls -1tcdoq "{}" + | \
		grep \
		--ignore-case \
		--extended-regexp \
		".*${regex_pattern}.*" | \
		head -${number_of_results} | \
		awk '{out=$8; for(i=9;i<=NF;i++){out=out" "$i}; printf(out); printf("\n") }');
		
				
		# return first result from first line #
	    
		folder_path=$( echo "${regex_match}" | sed -n '1p' )
		
		echo "${regex_match}"
		echo "--returned first ${number_of_results} results by most recent--";
			
		# set the number results to search for ``--results`` #

	elif [[ "$1" == "-r"  || "$1" == "--results" ]] ; then
		
		local number_of_results="${2}"
		local regex_pattern="${3}"

		regex_match=$( \
		find . -type d -name "*" -maxdepth 1 -exec ls -1tcdoq "{}" + | \
		grep \
		--ignore-case \
		--extended-regexp \
		".*${regex_pattern}.*" | \
		head -${number_of_results} | \
		awk '{out=$8; for(i=9;i<=NF;i++){out=out" "$i}; printf(out); printf("\n") }');
		
		
		# return the results from first line #
		
		folder_path=$( echo "${regex_match}" | sed -n '1p' )
		
		echo "${regex_match}"
		echo "--returned first ${number_of_results} results by most recent--";

	elif [[ "$1" == "open" || "$1" == "--open" ]]; then
		local regex_pattern="${2}"
		regex_match=$( \
		find . -type d -name "*" -maxdepth 1 -exec ls -1tcdoq "{}" + | \
		grep \
		--ignore-case \
		--extended-regexp \
		".*${regex_pattern}.*" | \
		head -5 | \
		awk '{out=$8; for(i=9;i<=NF;i++){out=out" "$i}; printf(out); printf("\n") }');
		# return first result from first line #		
		folder_path=$( echo "${regex_match}" | sed -n '1p' )
		open "${folder_path}"
	else
		echo 'error: no value entered'
	fi

}