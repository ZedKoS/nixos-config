{
  config,
  pkgs,
  stylix,
  username,
  host,
  ...
}: {
  imports = [
    ./terminal.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # Handle service switching
  systemd.user.startServices = "sd-switch";

  # Change this value only if you know what you're doing
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    neofetch
    chezmoi
  ];

  programs = {
    # Replacements for some system utils
    bat.enable = true;
    eza.enable = true;
    zoxide.enable = true;
    fzf.enable = true;

    helix = {
      enable = true;
      defaultEditor = true;
      extraPackages = [
        pkgs.marksman
      ];
    };

    librewolf = {
      enable = true;
    };

    ssh = {
      enable = true;
      addKeysToAgent = "yes";
    };
  };

  stylix.targets.helix.enable = false;

  # i18n.glibcLocales = {};
}
