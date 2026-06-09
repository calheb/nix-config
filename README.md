
<p align="left">
  <img height=100 src="https://raw.githubusercontent.com/NixOS/nixos-artwork/9d2cdedd73d64a068214482902adea3d02783ba8/logo/nix-snowflake-colours.svg">
</p>
<h1>nix-config</h1>

```
sudo nixos-rebuild switch --flake ~/nix-config#nixos
```


## structure
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
