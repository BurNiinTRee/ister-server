{ config, ... }:
{
  nixpkgs.config.allowUnfree = true;
  services.minecraft-server = {
    enable = true;
    eula = true;
    declarative = true;
    openFirewall = true;
    whitelist = {
      "BurNiinTRee" = "c01f2fec-a3c4-44a4-ba88-2ea59e3184b0";
    };
  };

  persist.directories = [ config.services.minecraft-server.dataDir ];
}
