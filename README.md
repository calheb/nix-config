<p align="left">
  <img height=100 src="https://raw.githubusercontent.com/NixOS/nixos-artwork/9d2cdedd73d64a068214482902adea3d02783ba8/logo/nix-snowflake-colours.svg">
</p>
<h1>nix-config</h1>

My [NixOS] configuration with [Nix Flakes], [Home Manager], and [Hyprland].

## Structure
```
❯ tree -L 3 ~/nix-config/

/home/caleb/nix-config/
├── flake.lock
├── flake.nix
├── hosts/
│   └── nixos/
│       ├── configuration.nix
│       └── hardware-configuration.nix
├── README.md
└── users/
    └── caleb/
        ├── config/
        └── home.nix
```
<br>
<img width="3840" height="2560" alt="Image" src="https://github.com/user-attachments/assets/3365ff74-aff4-4104-a0c5-5706722bb7ff" /><br><br>
<img width="3769" height="2441" alt="Image" src="https://github.com/user-attachments/assets/5a7347c9-b5c4-4d75-b8ff-fd30fbac8ffc" /><br><br>
<img width="1873" height="1209" alt="Image" src="https://github.com/user-attachments/assets/d83a6fb1-c4eb-499a-bb1f-f5f51c60c09b" /><br>

## Usage

**try it in a VM**
```bash
git clone https://github.com/calheb/nix-config && cd nix-config
nixos-rebuild build-vm --flake .#nixos
./result/bin/run-nixos-vm
```

## TODO
- [ ] Migrate programs from home.nix to individual modules.
- [ ] Migrate Neovim to Home Manager.
- [ ] Migrate Hyprland to Home Manager.
- [ ] Configure Waybar.


[NixOS]: https://nixos.org/
[Nix Flakes]: https://wiki.nixos.org/wiki/Flakes/
[Home Manager]: https://nix-community.github.io/home-manager/
[Hyprland]: https://hyprland.org/

