{
  config,
  lib,
  pkgs,
  stylix,
  username,
  host,
  ...
}: {
  imports = [
    ./modules
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  nixpkgs.config.allowUnfree = true;

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # Handle service switching
  systemd.user.startServices = "sd-switch";

  # Change this value only if you know what you're doing
  home.stateVersion = "24.11";

  # i18n.glibcLocales = {};
}
