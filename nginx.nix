{
  lib,
  config,
  options,
  ...
}: {
  services.nginx = {
    enable = true;
    recommendedTlsSettings = true;
    recommendedOptimisation = true;
    recommendedBrotliSettings = true;
    recommendedGzipSettings = true;
    recommendedProxySettings = true;
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "lars@muehml.eu";
  };

  persist.directories = [
    "/var/lib/acme"
  ];

  networking.firewall.allowedTCPPorts = [80 443];
}
