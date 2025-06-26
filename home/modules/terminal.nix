{...}: {
  programs = {
    # Shell
    fish = {
      enable = true;
      # Disable greeting message
      interactiveShellInit = "set -g fish_greeting";
    };

    nushell = {
      enable = true;
    };

    # Multi-shell autocompletion
    carapace = {
      enable = true;
    };

    # Terminal emulator

    kitty = {
      enable = true;

      settings = {
        disable_ligatures = "cursor";
      };

      # Include extra config not managed by home-manager
      # extraConfig = "include other.conf"
    };

    # Terminal prompt
    starship = {
      enable = true;

      settings = {
        add_newline = true;

        # format = ''

        # '';

        # character = {
        #   success_symbol = null;

        # };
      };
    };
  };

  home.shellAliases = {
    # Utils
    ls = "eza --icons";
    la = "eza -bla --icons";
    tree = "eza -T --icons";

    # Man pages for configuration.nix and home-configuration.nix
    nixconf = "man configuration.nix";
    homeconf = "man home-configuration.nix";
  };
}
