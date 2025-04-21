{
  config,
  pkgs,
  username,
  host,
  ...
}:

{
  home.username = username;
  home.homeDirectory = "/home/${username}";

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # Change this value only if you know what you're doing
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    neofetch
  ];

  programs = {
    bash.enable = true;

    bat.enable = true;
    eza.enable = true;

    helix = {
      enable = true;

      defaultEditor = true;

      extraPackages = [
        pkgs.marksman
      ];

      settings = {
        theme = "tokyonight";

        editor = {
          line-number = "relative";
          lsp.display-messages = true;
        };
      };
    };

    librewolf.enable = true;
  };

  home.shellAliases = {
    ls = "eza -b";
    tree = "eza -T";

    cat = "bat";
  };

  # i18n.glibcLocales = {};
}
