{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    impermanence.url = "github:nix-community/impermanence";
    disko.url = "github:nix-community/disko/latest";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self, nixpkgs, impermanence, sops-nix, disko}: {
    nixosConfigurations.ister = nixpkgs.lib.nixosSystem {
      modules = [
        ./configuration.nix
        impermanence.nixosModules.impermanence
        sops-nix.nixosModules.sops
        disko.nixosModules.disko
      ];
    };
  };
}
