{...}: {
  programs = {
    # Shell
    fish = {
      enable = true;

      # Disable greeting message
      interactiveShellInit = "set -g fish_greeting";

      shellAliases = {
        # Utils
        ls = "eza --icons";
        la = "eza -bla --icons";
        tree = "eza -T --icons";
      };
    };

    nushell = {
      enable = true;
      shellAliases = {
        tree = "eza -T --icons";
      };
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
      extraConfig = "include other.conf";
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

  # Compatible across all shells
  home.shellAliases = {
    # Man pages for configuration.nix and home-configuration.nix
    nixconf = "man configuration.nix";
    homeconf = "man home-configuration.nix";
  };
}
