{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    impermanence.url = "github:nix-community/impermanence";
  };

  outputs = {self, nixpkgs, impermanence}: {
    nixosConfigurations.ister = nixpkgs.lib.nixosSystem {
      modules = [
        ./configuration.nix
        impermanence.nixosModules.impermanence
      ];
    };
  };
}
