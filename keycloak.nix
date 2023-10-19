{config, ...}: {

  services.keycloak = {
    enable = true;
    settings = {
      hostname = "";
      hostname-url = "http://ister.local/";
      http-enabled = true;
      proxy = "edge";
    };
    database.passwordFile = config.sops.secrets."keycloak/db_password".path;

  };


  sops.secrets."keycloak/db_password" = {};

  networking.hosts = {
    "127.0.0.1" = [ "ister.local" ];
  };
}
