
function findr() {
	
	local regex_pattern="${1}"
	local regex_match;
	local folder_path;
	local current_path=$(pwd);
			
	if [ ! -z "$1" ];
 	then
		
		# -- return first five results from regex match -- #
				
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
		
		echo "${regex_match}"
		echo '--returned first five results by most recent--';
		
		
		# open the folder or file with the subcommand ``--open`` #
		
		if [ "$1" == "open" ] || [ "$1" == "--open" ];
	 	then
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
			echo ''
		fi			
				
					
	else
		echo 'error: no value entered'
	fi

}