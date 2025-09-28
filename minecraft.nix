{ config, ... }:
{
  nixpkgs.config.allowUnfree = true;
  services.minecraft-server = {
    enable = true;
    eula = true;
    declarative = false;
    openFirewall = true;
  };

  persist.directories = [ config.services.minecraft-server.dataDir ];
}
