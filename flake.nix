{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";
  };

  outputs =
    { self, nixpkgs, ... }:
    let
      inherit (nixpkgs.lib) genAttrs nixosSystem;
    in
    {
      nixosConfigurations.nixos = nixosSystem {
        system = "x86_64-linux";

        specialArgs = {
          nix-config = self;
        };

        modules = [
          ./hosts/nixos
        ];
      };

      formatter = genAttrs [ "x86_64-linux" "aarch64-linux" ] (
        system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style
      );
    };
}
