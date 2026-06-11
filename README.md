<p align="left">
  <img height=100 src="https://raw.githubusercontent.com/NixOS/nixos-artwork/9d2cdedd73d64a068214482902adea3d02783ba8/logo/nix-snowflake-colours.svg">
</p>

# nix-config

<p>
  <img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/palette/macchiato.png" height=20 width=100% />
</p>

My [NixOS] configuration with [Nix Flakes], [Home Manager], and [Hyprland].

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

## Screenshots

<img width="3840" height="2560" alt="Image" src="https://github.com/user-attachments/assets/301a1f25-cff6-407b-a7a7-80304b29eba1" /><br><br>
<img width="3840" height="2560" alt="Image" src="https://github.com/user-attachments/assets/80afa56d-23b3-49f1-8060-a6a57669bf08" /><br><br>
<img width="3840" height="2560" alt="Image" src="https://github.com/user-attachments/assets/434ff757-9942-43d1-ad6c-929907736412" /><br>

## Usage

Try out my system configuration in a VM:
```bash
git clone https://github.com/calheb/nix-config && cd nix-config
nixos-rebuild build-vm --flake .#lemma
./result/bin/run-nixos-vm
```

## TODO
- [ ] Migrate Hyprland config to Home Manager.
- [ ] Update treesitter to non-legacy and preserve syntax highlighting.

[NixOS]: https://nixos.org/
[Nix Flakes]: https://wiki.nixos.org/wiki/Flakes/
[Home Manager]: https://nix-community.github.io/home-manager/
[Hyprland]: https://hyprland.org/
