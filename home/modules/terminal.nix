{...}: {
  programs = {
    fish = {
      enable = true;
      # Disable greeting message
      interactiveShellInit = "set -g fish_greeting";
    };

    kitty = {
      enable = true;

      settings = {
        disable_ligatures = "cursor";
      };

      # Include extra config not managed by home-manager
      # extraConfig = "include other.conf"
    };
  };

  home.shellAliases = {
    # Utils
    ls = "eza --icons";
    la = "eza -bla --icons";
    tree = "eza -T --icons";
  };
}
