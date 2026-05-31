#Add Git submodule
git submodule add https://github.com/username/other-repo.git path/to/subfolder
#Commit after adding submodule
git commit -m "Added other-repo as submodule"
#When cloning on a new device 
git clone --recurse-submodules https://github.com/username/main-repo.git

#IF already cloned without submodules
git submodule update --init --recursive

#To keep submodule synced and updated 
git submodule update --remote --merge
#To Push changes into submodule folder
cd path/to/subfolder
git add .
git commit -m "Update submodule content"
git push

----------------------------------------------
#IF adding other repo code fully inside a main repo without submodule, use subtree
git subtree add --prefix=path/to/subfolder https://github.com/username/other-repo.git main
#The submodule approach is cleaner if you want to keep the repos separate but linked. 
#The subtree approach is better if you want everything managed as one repo.
-----------------------------------------------

