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
        package = pkgs.neoforgeServers.neoforge-21_1;
        jvmOpts = "-Xms2G -Xmx3G";
      };
    };
  };

  systemd.services.minecraft-server-create.serviceConfig.TimeoutStartSec = "300";

  persist.directories = [
    config.services.minecraft-server.dataDir
    config.services.minecraft-servers.dataDir
  ];
}
