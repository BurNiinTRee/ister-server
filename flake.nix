{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    impermanence.url = "github:nix-community/impermanence";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self, nixpkgs, impermanence, sops-nix}: {
    nixosConfigurations.ister = nixpkgs.lib.nixosSystem {
      modules = [
        ./configuration.nix
        impermanence.nixosModules.impermanence
        sops-nix.nixosModules.sops
      ];
    };
  };
}
