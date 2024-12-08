{
  config,
  pkgs,
  lib,
  ...
}: {
  sops.secrets."discourse/adminPass".owner = "discourse";
  services.discourse = {
    enable = true;
    hostname = "forum.${config.networking.fqdnOrHostName}";
    enableACME = false;
    sslCertificate = config.sops.secrets.cert.path;
    sslCertificateKey = config.sops.secrets.cert-key.path;
    backendSettings.redis_port = 6380;
    admin = {
      username = "admin";
      email = "lars@muehml.eu";
      fullName = "Lars";
      # # passwordFile is of type `path` which must be a string starting with /
      # # Hence we add a / prefix and remove any / prefix of the expanded $CREDENTIALS_DIRECTORY
      # passwordFile = "/\${CREDENTIALS_DIRECTORY#/}/adminPass";
      passwordFile = config.sops.secrets."discourse/adminPass".path;
    };
    plugins = with config.services.discourse.package.plugins; [
      discourse-openid-connect
    ];
    database.ignorePostgresqlVersion = true;
  };

}
