# Most Used Commands and Scripts

A personal reference of Linux/Windows scripts and commands for quick copy-paste access. Covers everything from fresh OS setup to daily development tasks.

---

## Docs Index

| File | Contents |
|------|----------|
| [git.md](docs/git.md) | Git submodules, subtrees, SSH setup, branching, stashing, undoing, tags, aliases |
| [docker.md](docs/docker.md) | Docker install (Ubuntu + Raspberry Pi), images, containers, Compose, volumes, cleanup |
| [nodejs-nvm.md](docs/nodejs-nvm.md) | NVM install, Node.js, npm, Bun commands |
| [java.md](docs/java.md) | OpenJDK install, version switching, SDKMAN, Maven, Gradle |
| [python-conda.md](docs/python-conda.md) | Anaconda/Miniconda install, conda envs, pip, pyenv, venv |
| [linux-apps.md](docs/linux-apps.md) | VS Code, Spotify, Chrome, Brave, GitHub CLI, Flatpak, Snap |
| [expo-android.md](docs/expo-android.md) | Expo local Android build setup, EAS CLI, Android SDK |
| [linux-system.md](docs/linux-system.md) | Fan control, QEMU/KVM, VMware, disk management, systemd, cron |
| [find-and-search.md](docs/find-and-search.md) | find, grep, sed, perl, awk, locate, ripgrep, fd |
| [file-operations.md](docs/file-operations.md) | cp/mv/rm, permissions, compression, rsync, text processing, batch rename |
| [system-info.md](docs/system-info.md) | CPU/RAM/disk/GPU info, temperature monitoring, process monitoring, logs |
| [network.md](docs/network.md) | IP info, DNS, SSH, scp, rsync, wget, firewall (UFW), port scanning |
| [windows.md](docs/windows.md) | Skip MS login, WSL, winget, Chocolatey, CMD & PowerShell commands |

---

## Quick Reference

### Fresh Ubuntu Install Checklist
1. [Install Docker](docs/docker.md#install-docker-on-ubuntu)
2. [Install Node.js via NVM](docs/nodejs-nvm.md#install-nvm--nodejs--bun-ubuntu)
3. [Install VS Code](docs/linux-apps.md#vs-code--install-via-apt-ubuntu)
4. [Set up GitHub SSH](docs/git.md#github-ssh-setup)
5. [Install GitHub CLI](docs/linux-apps.md#github-cli-gh)

### Common Tasks
- **Find a file**: [find-and-search.md](docs/find-and-search.md)
- **Replace text across files**: [find-and-search.md → sed/perl](docs/find-and-search.md#sed--stream-editor-find-and-replace)
- **Check what's using a port**: [network.md → Open Ports](docs/network.md#open-ports-and-sockets)
- **Monitor system resources**: [system-info.md](docs/system-info.md)
- **Sync files to a server**: [network.md → rsync](docs/network.md#rsync--efficient-sync)
