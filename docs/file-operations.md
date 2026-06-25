# File Operations Reference

## Basic File Commands

```bash
# Copy
cp file.txt /destination/                         # copy a file
cp -r folder/ /destination/                       # copy directory recursively
cp -p file.txt /destination/                      # preserve permissions and timestamps
cp -u file.txt /destination/                      # copy only if source is newer

# Move / Rename
mv file.txt /destination/                         # move a file
mv old-name.txt new-name.txt                      # rename a file
mv -n file.txt /destination/                      # don't overwrite existing file

# Delete
rm file.txt                                       # delete a file
rm -r folder/                                     # delete directory recursively
rm -f file.txt                                    # force delete (no error if missing)
rm -rf folder/                                    # force delete directory (use carefully!)
rmdir folder/                                     # delete empty directory only

# Create
touch file.txt                                    # create empty file or update timestamp
mkdir folder                                      # create directory
mkdir -p path/to/nested/folder                    # create nested directories
```

---

## Viewing and Navigating

```bash
ls                                                # list files
ls -la                                            # list all with details
ls -lh                                            # human-readable file sizes
ls -lt                                            # sort by modification time (newest first)
ls -lS                                            # sort by size (largest first)
ls -R                                             # recursive list
tree                                              # visual tree (sudo apt install tree)
tree -L 2                                         # tree, max 2 levels deep
tree -a                                           # include hidden files
pwd                                               # print current directory
```

---

## File Info

```bash
file filename                                     # determine file type
stat filename                                     # full file metadata
du -sh folder/                                    # size of directory (human readable)
du -sh *                                          # size of each item in current dir
du -sh * | sort -rh                               # sorted by size, largest first
df -h                                             # disk space usage for all mounts
wc -l file.txt                                    # count lines
wc -w file.txt                                    # count words
wc -c file.txt                                    # count bytes
```

---

## Permissions

```bash
chmod 755 file.sh                                 # rwxr-xr-x (owner: all, others: read+exec)
chmod 644 file.txt                                # rw-r--r-- (owner: read+write, others: read)
chmod 600 secret.pem                              # rw------- (owner only)
chmod +x file.sh                                  # add execute permission for all
chmod -R 755 folder/                              # apply permissions recursively
chown user:group file.txt                         # change owner and group
chown -R user:group folder/                       # change owner recursively
chgrp groupname file.txt                          # change group only
sudo chown -R $USER:$USER folder/                 # take ownership of a folder
```

### Permission reference
| Octal | Symbolic   | Meaning                   |
|-------|------------|---------------------------|
| 777   | rwxrwxrwx  | Full access to everyone   |
| 755   | rwxr-xr-x  | Owner full, others r+x    |
| 644   | rw-r--r--  | Owner rw, others read     |
| 600   | rw-------  | Owner rw only             |
| 400   | r--------  | Owner read only           |

---

## Symbolic Links

```bash
ln -s /path/to/original /path/to/link             # create a symlink
ln -sf /new/target existing-link                   # update (force overwrite) symlink
ls -la                                             # see symlinks (shown with ->)
readlink -f link-name                              # resolve symlink to real path
```

---

## Compression and Archives

### tar
```bash
tar -czvf archive.tar.gz folder/                  # create gzip archive
tar -xzvf archive.tar.gz                          # extract gzip archive
tar -xzvf archive.tar.gz -C /destination/         # extract to specific directory
tar -cjvf archive.tar.bz2 folder/                 # create bz2 archive
tar -xjvf archive.tar.bz2                         # extract bz2 archive
tar -tf archive.tar.gz                            # list contents without extracting
tar --exclude="node_modules" -czvf archive.tar.gz folder/  # exclude a directory
```

### zip / unzip
```bash
zip -r archive.zip folder/                        # create zip archive
zip -r archive.zip folder/ -x "*/node_modules/*" # exclude a directory
unzip archive.zip                                 # extract to current directory
unzip archive.zip -d /destination/                # extract to specific directory
unzip -l archive.zip                              # list contents without extracting
```

### gzip
```bash
gzip file.txt                                     # compress (replaces original with .gz)
gzip -k file.txt                                  # compress and keep original
gunzip file.txt.gz                                # decompress
gzip -d file.txt.gz                               # same as gunzip
```

---

## Text Processing

```bash
cat file.txt                                      # print file contents
less file.txt                                     # view file with scroll (press q to quit)
head -20 file.txt                                 # first 20 lines
tail -20 file.txt                                 # last 20 lines
tail -f logfile.log                               # follow a log file in real time
sort file.txt                                     # sort lines alphabetically
sort -n numbers.txt                               # numeric sort
sort -r file.txt                                  # reverse sort
sort -k2 file.txt                                 # sort by second column
sort -u file.txt                                  # sort and remove duplicates
uniq file.txt                                     # remove consecutive duplicates
sort file.txt | uniq                              # remove all duplicates
sort file.txt | uniq -c | sort -rn                # count occurrences, most first
cut -d',' -f1 file.csv                            # extract first CSV column
cut -d':' -f1 /etc/passwd                         # extract first field using : delimiter
tr 'a-z' 'A-Z' < file.txt                         # convert lowercase to uppercase
tr -d '\r' < file.txt > cleaned.txt               # remove carriage returns (Windows line endings)
diff file1.txt file2.txt                          # compare two files
diff -u file1.txt file2.txt                       # unified diff format (git-style)
```

---

## Batch Rename Files

```bash
# Rename all .jpeg to .jpg
for f in *.jpeg; do mv "$f" "${f%.jpeg}.jpg"; done

# Add prefix to all files
for f in *.txt; do mv "$f" "prefix_$f"; done

# Replace spaces with underscores in filenames
for f in *\ *; do mv "$f" "${f// /_}"; done

# Using rename (install: sudo apt install rename)
rename 's/\.jpeg/.jpg/' *.jpeg                    # rename .jpeg to .jpg
rename 's/ /_/g' *                                # replace spaces with underscores
rename 's/^/prefix_/' *.txt                       # add prefix
rename 's/_/-/g' *                                # replace underscores with dashes
```

---

## File Sync (rsync)

```bash
rsync -avz source/ destination/                   # sync local folders
rsync -avz folder/ user@host:/remote/folder/      # sync to remote server
rsync -avz user@host:/remote/folder/ ./local/     # sync from remote server
rsync -avz --delete source/ destination/          # delete files removed from source
rsync -avz --exclude="node_modules" . user@host:/path/   # exclude a folder
rsync -n -avz source/ destination/               # dry run (preview changes)
rsync --progress -avz large-file.iso user@host:/  # show progress
```

---

## Disk Operations

```bash
# Copy an entire disk/partition (raw clone)
sudo dd if=/dev/sda of=/dev/sdb bs=4M status=progress   # clone disk to disk
sudo dd if=/dev/sda of=backup.img bs=4M status=progress # clone disk to image file
sudo dd if=backup.img of=/dev/sda bs=4M status=progress # restore image to disk

# Create a blank file of specific size
dd if=/dev/zero of=test.img bs=1M count=100             # create 100MB blank file
fallocate -l 1G bigfile                                  # create 1GB file instantly
```

---

## Useful One-Liners

```bash
# Find and replace across all files in a project
grep -rl "old_text" . | xargs sed -i 's/old_text/new_text/g'

# Show 10 largest files in a directory
du -ah . | sort -rh | head -10

# Count files in a directory recursively
find . -type f | wc -l

# Remove all .DS_Store files (common macOS clutter)
find . -name ".DS_Store" -delete

# Remove all empty directories
find . -type d -empty -delete

# Create a dated backup copy of a file
cp important.conf important.conf.$(date +%Y%m%d)

# List files sorted by modification date (newest first)
ls -lt

# Show file encoding
file -i file.txt
```
