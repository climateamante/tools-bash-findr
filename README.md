# Bash tool for finding and returning results #
 > updated: 03.30.2018
 - example: return the first five results in the current directory
     
```bash
	findr search-tearm
```
 - example: open the first result (folder or file)

```bash
	findr --open search-tearm
```

#### todo: ####

 * [x] change the number of results from parameter flag ``-r``
 > completed: 03/30/2018
 ```bash
 findr -r 20 "file name to search that has spaces"
 ```