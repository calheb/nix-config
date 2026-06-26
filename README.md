<p align="left">
  <img height=100 src="https://raw.githubusercontent.com/NixOS/nixos-artwork/9d2cdedd73d64a068214482902adea3d02783ba8/logo/nix-snowflake-colours.svg">
</p>

# nix-config

<p>
  <img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/palette/macchiato.png" height=20 width=100% />
</p>

My personal development environment.

- **Editor:** [Emacs]
- **Shell:** [Bash] | [conch]
- **Prompt:** [Starship]
- **Terminal:** [Ghostty]
- **OS:** [NixOS] | [Home Manager] | [Hyprland]
- **Theme:** [Catppuccin] | [gruber-darker]

<!--
## Structure
```
❯ tree ~/nix-config

/home/caleb/nix-config
├── config
│   └── hypr
│       └── hyprland.lua
├── flake.lock
├── flake.nix
├── home
│   └── caleb
│       ├── core.nix
│       ├── default.nix
│       ├── desktop.nix
│       ├── emacs.nix
│       ├── git.nix
│       ├── neovim.nix
│       ├── packages.nix
│       ├── shell.nix
│       ├── terminals.nix
│       ├── user-theme.nix
│       └── waybar.nix
├── hosts
│   └── lemma
│       ├── configuration.nix
│       ├── default.nix
│       ├── hardware-configuration.nix
│       └── system-theme.nix
├── LICENSE
├── modules
│   └── nixos
│       └── home-manager.nix
└── README.md
```
-->

## Screenshots

<img width="3840" height="2560" alt="Image" src="https://github.com/user-attachments/assets/301a1f25-cff6-407b-a7a7-80304b29eba1" /><br><br>
<img width="3840" height="2560" alt="Image" src="https://github.com/user-attachments/assets/ab0a6d90-1e3e-4606-b5c2-804778dc6194" /><br><br>
<img width="3840" height="2560" alt="Image" src="https://github.com/user-attachments/assets/434ff757-9942-43d1-ad6c-929907736412" /><br>

## Usage

Try out my system configuration in a VM:
```bash
git clone https://github.com/calheb/nix-config && cd nix-config
nixos-rebuild build-vm --flake .#lemma
./result/bin/run-lemma-vm
```

## TODO
- [ ] Migrate Hyprland config to Home Manager once Lua integration is more mature.
- [ ] Add home server config to hosts/.
- [ ] Add laptop config to hosts/.

[NixOS]: https://nixos.org/
[Nix Flakes]: https://wiki.nixos.org/wiki/Flakes/
[Home Manager]: https://nix-community.github.io/home-manager/
[Hyprland]: https://hyprland.org/
[Catppuccin]: https://catppuccin.com/
[gruber-darker]: https://github.com/rexim/gruber-darker-theme/
[Bash]: https://www.gnu.org/software/bash/
[conch]: https://github.com/calheb/conch/
[Emacs]: https://www.gnu.org/software/emacs/
[Starship]: https://github.com/starship/starship/
[Ghostty]: https://github.com/ghostty-org/ghostty/
