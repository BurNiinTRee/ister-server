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
      "nagisalaw" = "8f49e82c-d776-4a13-8880-510e1128df23";
    };
    serverProperties = {
      white-list = true;
      difficulty = "normal";
      motd = "Isterbandet's Minecraft Server";
    };
  };

  persist.directories = [ config.services.minecraft-server.dataDir ];
}
