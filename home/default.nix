{
  config,
  pkgs,
  username,
  host,
  ...
}: {
  home.username = username;
  home.homeDirectory = "/home/${username}";

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # Change this value only if you know what you're doing
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    neofetch
    chezmoi
  ];

  programs = {
    fish = {
      enable = true;
      interactiveShellInit = "set -g fish_greeting";
    };

    kitty.enable = true;

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

    librewolf.enable = true;
  };

  home.shellAliases = {
    # Utils
    ls = "eza --icons";
    la = "eza -bla --icons";
    tree = "eza -T --icons";
    cat = "bat";
  };

  # i18n.glibcLocales = {};
}
