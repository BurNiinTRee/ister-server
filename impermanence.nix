{
  lib,
  ...
}: {
  imports = [
    (lib.mkAliasOptionModule [ "persist" "directories" ] [ "environment" "persistence" "/persist/root" "directories"])
    (lib.mkAliasOptionModule [ "persist" "files" ] [ "environment" "persistence" "/persist/root" "files"])
  ];

  persist.directories = [
    "/etc/nixos"
  ];
}