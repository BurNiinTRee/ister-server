{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    impermanence.url = "github:nix-community/impermanence";
    disko.url = "github:nix-community/disko/latest";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Until https://github.com/Infinidoge/nix-minecraft/pull/161 is merged, we use the
    # PR branch. It doesn't seem to be too old.
    nix-minecraft.url = "github:nathanregner/nix-minecraft?ref=neoforge";
    # nix-minecraft.url = "github:Infinidoge/nix-minecraft";
  };

  outputs =
    {
      self,
      nixpkgs,
      impermanence,
      sops-nix,
      disko,
      nix-minecraft,
    }:
    {
      nixosConfigurations.isterbandet1 = nixpkgs.lib.nixosSystem {
        modules = [
          ./configuration.nix
          impermanence.nixosModules.impermanence
          sops-nix.nixosModules.sops
          disko.nixosModules.disko
          nix-minecraft.nixosModules.minecraft-servers
          {
            nixpkgs.overlays = [ nix-minecraft.overlay ];
          }
        ];
      };
    };
}
