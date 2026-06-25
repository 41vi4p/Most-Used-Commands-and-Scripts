# Node.js / NVM / Bun Reference

## Install NVM + Node.js + Bun (Ubuntu)

```bash
sudo apt install curl
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash
source ~/.bashrc
nvm install node
node --version
npm --version
curl -fsSL https://bun.com/install | bash
bun --version
```

---

## Install NVM + Node.js + GitHub CLI + Bun (Full Dev Setup)

```bash
sudo apt update
sudo apt install ca-certificates curl gnupg -y
sudo apt install gh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
source ~/.bashrc
nvm install node
node --version
npm --version
curl -fsSL https://bun.com/install | bash
bun --version
```

---

## NVM Commands

```bash
nvm ls                                   # list installed Node versions
nvm ls-remote                            # list all available Node versions
nvm ls-remote --lts                      # list only LTS versions
nvm install node                         # install latest Node version
nvm install --lts                        # install latest LTS version
nvm install 20.19.4                      # install a specific version
nvm use 20.19.4                          # switch to specific version in current shell
nvm use --lts                            # switch to LTS version
nvm alias default 20.19.4               # set default version for new shells
nvm uninstall 18.0.0                     # uninstall a version
nvm current                              # show currently active version
nvm which 20.19.4                        # show path to a version's node binary
nvm exec 20.19.4 node --version          # run node command with specific version
```

---

## npm Commands

```bash
npm install                              # install all dependencies from package.json
npm install package-name                 # install a package (saves to dependencies)
npm install -D package-name              # install as dev dependency
npm install -g package-name              # install globally
npm install package-name@1.2.3          # install specific version
npm uninstall package-name               # uninstall a package
npm update                               # update all packages
npm update package-name                  # update specific package
npm outdated                             # check for outdated packages
npm run script-name                      # run a script from package.json
npm list                                 # list installed packages in project
npm list -g --depth=0                    # list globally installed packages
npm cache clean --force                  # clear npm cache
npx package-name                         # run package without installing globally
npm audit                                # check for security vulnerabilities
npm audit fix                            # auto-fix vulnerabilities
npm pack                                 # create a tarball of the package
npm publish                              # publish package to npm registry
npm link                                 # symlink local package for development
```

---

## Bun Commands

```bash
bun install                              # install dependencies (faster than npm install)
bun add package-name                     # add a package
bun add -d package-name                  # add as dev dependency
bun remove package-name                  # remove a package
bun update                               # update all packages
bun run script-name                      # run script from package.json
bun run index.ts                         # run a TypeScript file directly
bun x package-name                       # run a package without installing (like npx)
bun build ./src/index.ts --outdir ./dist # bundle a file
bun test                                 # run tests
bun --version                            # show bun version
```

---

## Common package.json Scripts

```json
{
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "eslint . --ext .ts,.tsx",
    "format": "prettier --write .",
    "test": "jest"
  }
}
```

---

## Useful One-Liners

```bash
# Check what's using a port
npx kill-port 3000

# Upgrade npm itself
npm install -g npm@latest

# Find where a global package is installed
npm root -g

# List scripts in current package.json
cat package.json | grep '"scripts"' -A 20

# Initialize a new project
npm init -y
bun init
```
