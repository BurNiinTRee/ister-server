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

  networking.firewall.allowedTCPPorts = [80 443];
}
