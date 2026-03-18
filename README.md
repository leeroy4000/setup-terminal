# setup-terminal

A bootstrap script that sets up a consistent terminal environment on any Debian-based machine. Run it once on a fresh system to get the same shell experience across all machines.

## What It Installs

| Tool | Purpose |
|------|---------|
| zsh | Shell replacement for bash |
| Oh My Zsh | Framework for managing zsh configuration |
| zsh-autosuggestions | Gray suggestions as you type based on history |
| zsh-syntax-highlighting | Colors commands green/red as you type |
| fzf | Fuzzy finder — powers Ctrl+R history search |
| Starship | Smart prompt showing user, host, directory, and git status |

## What It Configures

- **Prompt**: `user@hostname ~/path ❯` with yellow user, cyan hostname, green/red indicator
- **Aliases**: Common shortcuts for navigation, file listing, safety nets, and system tasks
- **Default shell**: Sets zsh as your login shell

## Usage

### On a new machine

```bash
curl -fsSL https://raw.githubusercontent.com/leeroy4000/setup-terminal/main/setup-terminal.sh | bash
```

Or clone and run locally:

```bash
git clone https://github.com/leeroy4000/setup-terminal.git
cd setup-terminal
bash setup-terminal.sh
```

### After running

Open a new terminal window — everything will be active. No need to run anything else.

If you're in an existing session, run:
```bash
exec zsh
```

## Aliases Included

| Alias | Command | Purpose |
|-------|---------|---------|
| `..` | `cd ..` | Go up one directory |
| `...` | `cd ../..` | Go up two directories |
| `....` | `cd ../../..` | Go up three directories |
| `ll` | `ls -lah` | Detailed list with hidden files |
| `la` | `ls -A` | Show all files including hidden |
| `lf` | `ls -lah \| grep` | Search directory listing |
| `rm` | `rm -i` | Ask before deleting |
| `cp` | `cp -i` | Ask before overwriting |
| `mv` | `mv -i` | Ask before overwriting |
| `zshrc` | `nano ~/.zshrc` | Open zsh config |
| `reload` | `source ~/.zshrc` | Apply config changes |
| `update` | `sudo apt update && sudo apt upgrade -y` | Update all packages |
| `ports` | `ss -tulnp` | Show open ports |
| `myip` | `curl -s ifconfig.me` | Show public IP |
| `df` | `df -h` | Disk usage |
| `free` | `free -h` | Memory usage |
| `c` | `clear` | Clear screen |
| `h` | `history` | Show command history |
| `q` | `exit` | Exit terminal |

## Requirements

- Debian-based Linux (Debian, Ubuntu, Linux Mint, etc.)
- `sudo` access for package installation
- Internet connection

## Notes

- Safe to run on machines where some tools are already installed — each step checks before installing
- Does not overwrite an existing `.zshrc` or `.config/starship.toml` if you've customized them — back those up first if needed
