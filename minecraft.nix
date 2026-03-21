{ config, lib, pkgs, ... }:
{
  networking.firewall.allowedUDPPorts = [ 24454 25565 ];
  networking.firewall.allowedTCPPorts = [ 25565 ];

  systemd.services.gate = {
    wantedBy = ["multi-user.target"];
    script = ''${pkgs.gate}/bin/gate -c ${./gate-config.yaml}'';
  };
}
