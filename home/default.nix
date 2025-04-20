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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Be careful when changing this value
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    neofetch
  ];

  programs = {
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
  };

  # home.sessionVariables = {
  #   EDITOR = "hx";
  # };
}
