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
      "John_Cheese" = "9538b89e-d589-402b-988e-d57a9cc7ca14";
      "petpeng" = "6363cf85-ab7c-45d3-81f4-63a9d1037c92";
    };
    serverProperties = {
      white-list = true;
      difficulty = "normal";
      motd = "Isterbandet's Minecraft Server";
    };
  };

  persist.directories = [ config.services.minecraft-server.dataDir ];
}
