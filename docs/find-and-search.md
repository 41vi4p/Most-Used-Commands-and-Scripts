# Find, Search & Replace Reference

## find — Locate Files and Directories

### By name
```bash
find . -name "*.txt"                              # find all .txt files (case sensitive)
find . -iname "config.js"                         # case insensitive
find . -type f -name "*.log"                      # files only
find . -type d -name "node_modules"               # directories only
find /home -name "*.sh"                           # search from a specific path
find . -name "*.ts" -o -name "*.tsx"              # OR condition
```

### By size
```bash
find . -size +100M                                # larger than 100MB
find . -size -1k                                  # smaller than 1KB
find . -size +10M -size -100M                     # between 10MB and 100MB
find . -empty -type f                             # empty files
find . -empty -type d                             # empty directories
```

### By modification time
```bash
find . -mtime -7                                  # modified in the last 7 days
find . -mtime +30                                 # modified more than 30 days ago
find . -newer reference_file.txt                  # newer than a reference file
find . -atime -1                                  # accessed in last 24 hours
find . -mmin -60                                  # modified in last 60 minutes
```

### By permissions and owner
```bash
find . -perm 644                                  # exact permissions
find . -perm /o+w                                 # world-writable files
find . -user username                             # owned by user
find . -group groupname                           # owned by group
```

### Excluding paths
```bash
find . -name "*.js" -not -path "*/node_modules/*"
find . -name "*.ts" -not -path "*/dist/*" -not -path "*/node_modules/*"
find . -name "*.log" -not -path "*/.git/*"
```

### Find and execute actions
```bash
find . -name "*.log" -exec rm {} \;               # delete all .log files
find . -name "*.sh" -exec chmod +x {} \;          # make all .sh files executable
find . -type f -exec ls -lh {} \;                 # show details of found files
find . -name "*.txt" -exec grep -l "pattern" {} \; # search inside found files

# Safer: preview first, then act
find . -name "*.tmp" -print                        # preview what would be deleted
find . -name "*.tmp" -delete                       # then delete
```

### Useful find combos
```bash
# Find largest files in a directory
find . -type f -exec du -h {} \; | sort -rh | head -20

# Find files modified today
find . -type f -mtime 0

# Find and list all symlinks
find . -type l

# Count files by extension
find . -type f | sed 's/.*\.//' | sort | uniq -c | sort -rn

# Find duplicate filenames (same name, different location)
find . -type f -printf '%f\n' | sort | uniq -d
```

---

## grep — Search Inside Files

### Basic search
```bash
grep "pattern" file.txt                           # search in a file
grep -r "pattern" .                               # recursive search in directory
grep -i "pattern" file.txt                        # case insensitive
grep -n "pattern" file.txt                        # show line numbers
grep -l "pattern" .                               # show only filenames that match
grep -L "pattern" .                               # files that DON'T match
grep -c "pattern" file.txt                        # count matching lines
grep -v "pattern" file.txt                        # lines NOT matching (invert)
```

### Context lines
```bash
grep -A 3 "pattern" file.txt                      # 3 lines after match
grep -B 3 "pattern" file.txt                      # 3 lines before match
grep -C 3 "pattern" file.txt                      # 3 lines around match
```

### Regular expressions
```bash
grep -E "pattern1|pattern2" file.txt              # OR (extended regex)
grep -E "^Error" file.txt                         # lines starting with "Error"
grep -E "\.js$" file.txt                          # lines ending with .js
grep -E "[0-9]{3}-[0-9]{4}" file.txt              # phone-like pattern
grep -P "\d+" file.txt                            # Perl regex (PCRE)
```

### Limit to file types
```bash
grep -r --include="*.ts" "function" .
grep -r --include="*.{js,ts}" "TODO" .
grep -r --exclude="*.log" "error" .
grep -r --exclude-dir={node_modules,dist,.git} "TODO" .
```

### Useful grep combos
```bash
# Find all TODOs, FIXMEs and HACs in code
grep -rn "TODO\|FIXME\|HACK" . --include="*.ts"

# Find which files import a specific module
grep -rl "from 'react'" . --include="*.tsx"

# Count occurrences of a word across files
grep -r "useEffect" . --include="*.tsx" | wc -l

# Show only the matched part (not the whole line)
grep -o "pattern" file.txt

# Search and show filename + line number
grep -rn "console.log" . --include="*.js"
```

---

## sed — Stream Editor (Find and Replace)

```bash
# Preview change (no file modification)
sed 's/old/new/g' file.txt

# Replace in place
sed -i 's/old/new/g' file.txt

# Replace only on a specific line
sed -i '5s/old/new/' file.txt

# Delete lines matching a pattern
sed -i '/pattern_to_delete/d' file.txt

# Delete blank lines
sed -i '/^$/d' file.txt

# Replace across multiple files (combine with find)
find . -type f -name "*.txt" -exec sed -i 's/old/new/g' {} \;

# Insert a line before/after a pattern
sed -i '/pattern/i\new line before' file.txt
sed -i '/pattern/a\new line after' file.txt
```

---

## perl — Powerful Find and Replace

```bash
# Replace across all files in a folder
perl -pi -e 's/old_value/new_value/g' $(find /path/to/folder -type f)

# Case-insensitive replace
perl -pi -e 's/old_value/new_value/gi' file.txt

# Replace in specific file types (exclude node_modules)
perl -pi -e 's/foo/bar/g' $(find . -name "*.js" -not -path "*/node_modules/*")

# Replace with a regex capture group
perl -pi -e 's/version: "(\d+)"/version: "$1.0"/g' package.json
```

---

## awk — Process Structured Text

```bash
awk '{print $1}' file.txt                         # print first column
awk '{print $NF}' file.txt                        # print last column
awk -F',' '{print $2}' file.csv                   # use comma as delimiter
awk 'NR==5' file.txt                              # print line 5
awk 'NR>=5 && NR<=10' file.txt                    # print lines 5-10
awk '/pattern/ {print}' file.txt                  # print lines matching pattern
awk '{sum += $1} END {print sum}' file.txt        # sum first column
awk '{print NR, $0}' file.txt                     # add line numbers
```

---

## locate / whereis / which

```bash
sudo updatedb                                     # update locate database first
locate filename                                   # find file anywhere on system
locate -i filename                                # case insensitive
locate "*.conf"                                   # pattern search
locate -c "*.log"                                 # count matching files

which python3                                     # show path of executable
which -a python3                                  # all matching executables in PATH
whereis git                                       # binary, source, and man page locations
type node                                         # show how a command is resolved
```

---

## ripgrep (rg) — Faster grep

> Install: `sudo apt install ripgrep`

```bash
rg "pattern"                                      # search in current directory (recursive)
rg "pattern" path/to/dir                          # search in specific directory
rg -i "pattern"                                   # case insensitive
rg -l "pattern"                                   # list files with matches
rg -n "pattern"                                   # show line numbers (default)
rg --type ts "pattern"                            # search only TypeScript files
rg -g "*.js" "pattern"                            # glob pattern for files
rg --no-ignore "pattern"                          # don't respect .gitignore
rg -A 3 "pattern"                                 # 3 lines after match
rg "pattern1" | rg "pattern2"                     # AND condition (chain)
```

---

## fd — Faster find

> Install: `sudo apt install fd-find` (then use `fdfind` or alias `fd=fdfind`)

```bash
fd "pattern"                                      # find files by name pattern
fd -e ts                                          # find by extension
fd -t f "pattern"                                 # files only
fd -t d "pattern"                                 # directories only
fd -H "pattern"                                   # include hidden files
fd --exclude node_modules "pattern"               # exclude directory
fd -e log -x rm                                   # find .log files and delete them
```
