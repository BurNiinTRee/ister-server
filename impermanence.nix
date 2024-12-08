{lib, ...}: {
  imports = [
    (lib.mkAliasOptionModule ["persist" "directories"] ["environment" "persistence" "/persist/root" "directories"])
    (lib.mkAliasOptionModule ["persist" "files"] ["environment" "persistence" "/persist/root" "files"])
  ];

  persist.directories = [
    "/etc/nixos"
  ];

  persist.files = [
    "/etc/ssh/ssh_host_ed25519_key"
    "/etc/ssh/ssh_host_ed25519_key.pub"
    "/etc/ssh/ssh_host_rsa_key"
    "/etc/ssh/ssh_host_rsa_key.pub"
  ];

  systemd.services.sshd = {
    after = ["local-fs.target"];
    requires = ["local-fs.target"];
  };

  fileSystems."/persist".neededForBoot = true;

  boot.initrd.postDeviceCommands = lib.mkAfter ''
    set -x
    waitDevice /dev/sda2
    mkdir /mnt
    mount /dev/sda2 /mnt
    btrfs subvolume delete /mnt/root/var/lib/portables
    btrfs subvolume delete /mnt/root/var/lib/machines
    btrfs subvolume delete /mnt/root/tmp
    btrfs subvolume delete /mnt/root/srv
    btrfs subvolume delete /mnt/root
    btrfs subvolume create /mnt/root
    umount /mnt
    rmdir /mnt
    set +x
  '';
}
