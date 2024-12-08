{config, ...}: {
  services.keycloak = {
    enable = true;
    settings = {
      hostname = "users.${config.networking.fqdnOrHostName}";
      http-port = 8080;
      http-host = "127.0.0.1";
      proxy-headers = "forwarded";
      proxy-trusted-addresses = "127.0.0.1";
    };
    database.passwordFile = config.sops.secrets."keycloak/db_password".path;
  };

  services.nginx.virtualHosts.${config.services.keycloak.settings.hostname} = {
    forceSSL = true;
    enableAcme = true;
    locations."/" = {
      proxyPass = "http://${config.services.keycloak.settings.http-host}:${toString config.services.keycloak.settings.http-port}";
    };
  };

  sops.secrets."keycloak/db_password" = {};
}
