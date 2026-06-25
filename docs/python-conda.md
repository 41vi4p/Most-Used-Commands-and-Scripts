# Python / Conda Reference

## Install Anaconda3 (~1GB, full data science toolkit)

> Do NOT run as root or with sudo.

```bash
wget https://repo.anaconda.com/archive/Anaconda3-2024.10-1-Linux-x86_64.sh
chmod +x Anaconda3-2024.10-1-Linux-x86_64.sh
./Anaconda3-2024.10-1-Linux-x86_64.sh
```

After install:
```bash
source ~/.bashrc
conda --version
```

---

## Install Miniconda3 (Minimal, ~100MB, install only what you need)

> Do NOT run as root or with sudo.

```bash
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh
source ~/.bashrc
conda --version
```

---

## Conda Environment Commands

```bash
conda create -n myenv python=3.11        # create environment with specific Python
conda create -n myenv python=3.11 numpy pandas  # create with packages
conda activate myenv                     # activate environment
conda deactivate                         # deactivate current environment
conda remove -n myenv --all              # delete environment
conda env list                           # list all environments
conda info --envs                        # same as above
conda env export > environment.yml       # export environment to file
conda env create -f environment.yml      # create from exported file
conda env update -f environment.yml      # update env from file
```

---

## Conda Package Commands

```bash
conda install numpy                      # install a package
conda install -n myenv numpy             # install into specific env
conda install numpy=1.26.0              # install specific version
conda install -c conda-forge package    # install from conda-forge channel
conda update numpy                       # update a package
conda update --all                       # update all packages in current env
conda remove numpy                       # remove a package
conda list                               # list installed packages
conda search numpy                       # search available versions
conda clean --all                        # remove cached packages and tarballs
```

---

## pip Commands (use inside conda envs)

```bash
pip install package-name                 # install a package
pip install package-name==1.2.3          # install specific version
pip install -r requirements.txt          # install from requirements file
pip uninstall package-name               # uninstall
pip list                                 # list installed packages
pip freeze > requirements.txt            # export requirements
pip show package-name                    # show package info and location
pip install --upgrade package-name       # upgrade a package
pip install --upgrade pip                # upgrade pip itself
pip cache purge                          # clear pip cache
```

---

## Python Version Management (pyenv)

### Install pyenv
```bash
curl https://pyenv.run | bash
# Add to ~/.bashrc:
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
source ~/.bashrc
```

### pyenv commands
```bash
pyenv install --list                     # list available Python versions
pyenv install 3.12.3                     # install a version
pyenv global 3.12.3                      # set global default
pyenv local 3.11.9                       # set version for current directory
pyenv versions                           # list installed versions
pyenv which python                       # show path to current python
```

---

## Virtual Environments (built-in venv)

```bash
python3 -m venv venv                     # create virtualenv named "venv"
source venv/bin/activate                 # activate (Linux/Mac)
venv\Scripts\activate                    # activate (Windows)
deactivate                               # deactivate
pip freeze > requirements.txt            # save dependencies
pip install -r requirements.txt          # restore dependencies
```

---

## Useful Python One-Liners

```bash
python3 --version                        # check Python version
python3 -m http.server 8000              # quick local HTTP server
python3 -c "import sys; print(sys.path)" # show Python path
python3 -m pip install --upgrade pip     # upgrade pip

# Find where a package is installed
python3 -c "import numpy; print(numpy.__file__)"

# Run a script with specific Python
/path/to/python3 script.py
```
