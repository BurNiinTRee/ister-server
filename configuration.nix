# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).
{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./disko-config.nix
    ./impermanence.nix
    ./keycloak.nix
    # ./discourse.nix
    ./nginx.nix
  ];

  # Use the systemD boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  networking.hostName = "isterbandet1"; # Define your hostname.
  networking.domain = "muehml.eu";

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.user = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN5s+IKT2XS2IpsKLXhhBydhBXVbfY3k2Ep8yhPqtB2z user@larstop2"
    ];
    hashedPassword = "$y$j9T$AhEVFB34jem1syXXY.Miu/$in1y.nOuhhjDAbwQosxHmUQphnQAHwo2W9UoMcNV7w/";
    extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
  };


  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = false;

  users.users.root = {
    openssh.authorizedKeys.keys = config.users.users.user.openssh.authorizedKeys.keys;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    helix
  ];

  environment.variables = {
    EDITOR = "hx";
  };

  sops.defaultSopsFile = ./secrets.yaml;
  sops.age.sshKeyPaths = ["/persist/root/etc/ssh/ssh_host_ed25519_key"];
  sops.gnupg.sshKeyPaths = [];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  networking.useNetworkd = true;
  systemd.network.enable = true;
  systemd.network.networks."30-wan" = {
    matchConfig.Name = "enp1s0";
    networkConfig.DHCP = "ipv4";
    address = [
      "2a01:4f9:c012:16eb::1/64"
    ];
    routes = [
      { Gateway = "fe80::1"; }
    ];
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
