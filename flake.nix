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
      systems = [ "x86_64-linux" "aarch64-linux" ];
      pkgsFor = system: nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations.lemma = nixosSystem {
        system = "x86_64-linux";

        specialArgs = {
          nix-config = self;
        };

        modules = [
          ./hosts/lemma
        ];
      };

      devShells = genAttrs systems (system: (pkgsFor system).mkShell {
        packages = with (pkgsFor system); [
          deadnix
          statix
          nixfmt-rfc-style
        ];
      });

      formatter = genAttrs systems (system: (pkgsFor system).nixfmt-rfc-style);
    };
}
