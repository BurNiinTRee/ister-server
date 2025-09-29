{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;
    servers = {
      create = {
        enable = true;
        package = pkgs.neoforge-servers_1_21_1;
        symlinks = {
          config = ./JustCreateSmp/config;
          mods = ./JustCreateSmp/mods;
        };
      };
    };
  };

  persist.directories = [ config.services.minecraft-server.dataDir config.services.minecraft-servers.dataDir ];
}
