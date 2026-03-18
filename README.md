# setup-terminal

A bootstrap script that sets up a consistent terminal environment on any Debian-based machine. Run it once on a fresh system to get the same shell experience across all machines.

## What It Installs

| Tool | Purpose |
|------|---------|
| zsh | Shell replacement for bash |
| Oh My Zsh | Framework for managing zsh configuration and plugins |
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

Download, make executable, and run:

```bash
curl -fsSL https://raw.githubusercontent.com/leeroy4000/setup-terminal/main/setup-terminal.sh -o setup-terminal.sh
chmod +x setup-terminal.sh
bash setup-terminal.sh
```

The script will install itself to `/usr/local/bin/setup-terminal.sh` automatically. After that you can run it from anywhere with:

```bash
setup-terminal.sh
```

### After running

Open a new terminal window — everything will be active. No need to run anything else.

If you're in an existing session, run:
```bash
exec zsh
```

### Backups

Before overwriting any config, the script saves timestamped backups:

- `~/.zshrc.bak.YYYYMMDDHHMMSS`
- `~/.config/starship.toml.bak.YYYYMMDDHHMMSS`

These let you recover any customizations you had before running the script.

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

## Tips & Tricks

### Keyboard shortcuts

| Shortcut | What it does |
|----------|-------------|
| `Ctrl+R` | Fuzzy search command history — type any part of a past command |
| `→` (right arrow) | Accept the gray autosuggestion |
| `Ctrl+C` | Cancel the current command |
| `Ctrl+L` | Clear the screen (same as `c`) |
| `Tab` | Autocomplete commands, paths, and filenames |
| `Tab Tab` | Show all possible completions when there are multiple matches |

### Everyday habits worth building

- Use `Ctrl+R` instead of pressing the up arrow repeatedly to find old commands
- Use `ll` instead of `ls` — you get sizes, permissions, and hidden files every time
- Use `..` and `...` to navigate up quickly instead of typing `cd ..`
- Watch the prompt color: `❯` turns red when the last command failed

### fzf beyond history

fzf can be used for more than `Ctrl+R`. It works as a general fuzzy selector:

```bash
# Interactively find and open a file
nano $(find . -type f | fzf)

# Interactively kill a process
kill $(ps aux | fzf | awk '{print $2}')
```

---

## Customization

### Oh My Zsh

Oh My Zsh is a framework that manages your zsh configuration. It provides:
- **Themes** — change how the prompt looks (though this setup uses Starship instead)
- **Plugins** — add functionality to your shell
- **Auto-updates** — keeps itself current

Your config lives in `~/.zshrc`. The key line is:
```bash
plugins=(git fzf zsh-autosuggestions zsh-syntax-highlighting)
```

To add a plugin, add its name to that list and run `reload`.

**Useful built-in plugins to try:**

| Plugin | What it adds |
|--------|-------------|
| `git` | Short aliases like `gst` (git status), `gp` (git push), `gl` (git pull) — already enabled |
| `docker` | Tab completion for docker commands |
| `sudo` | Press `Esc Esc` to add `sudo` to the front of the last command |
| `copypath` | `copypath` copies the current directory path to clipboard |

Add them to the plugins line in `~/.zshrc`, then run `reload`.

Full plugin list: [github.com/ohmyzsh/ohmyzsh/wiki/Plugins](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins)

### Starship prompt

Starship controls the prompt line. Config lives in `~/.config/starship.toml`.

**Change the prompt character:**
```toml
[character]
success_symbol = "[▶](green)"   # instead of ❯
```

**Add the time to your prompt:**
```toml
[time]
disabled = false
format = "[$time]($style) "
```

**Show Python/Node/etc. version when you're in a project:**
Starship does this automatically when it detects the right files (e.g. `package.json`, `requirements.txt`). No config needed.

Full config reference: [starship.rs/config](https://starship.rs/config/)

### Starship themes (presets)

Starship ships with built-in presets you can try:

```bash
# Preview a preset
starship preset pastel-powerline

# Apply a preset (overwrites your starship.toml)
starship preset pastel-powerline -o ~/.config/starship.toml
```

Available presets: `no-nerd-font`, `bracketed-segments`, `plain-text`, `no-runtime-versions`, `tokyo-night`, `pastel-powerline`, `gruvbox-rainbow`, `jetpack`

> **Note:** Some presets use Nerd Font icons. If your terminal shows garbled symbols, either install a Nerd Font or stick with `no-nerd-font` preset.

### Terminal font (Nerd Fonts)

Many prompt styles use special icons that require a Nerd Font. To use them:

1. Download a font from [nerdfonts.com](https://www.nerdfonts.com) (JetBrainsMono and FiraCode are popular choices)
2. Install it and set it in your terminal emulator's font settings
3. Then try a Starship preset that uses icons

---

## Requirements

- Debian-based Linux (Debian, Ubuntu, Linux Mint, etc.)
- `sudo` access for package installation
- Internet connection

## Notes

- Safe to run on machines where some tools are already installed — each step checks before installing
- Backs up existing `.zshrc` and `starship.toml` before overwriting
