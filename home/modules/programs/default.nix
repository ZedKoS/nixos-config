{ pkgs, username, ...}: {
  imports = [
    ./helix.nix
  ];

  home.packages = with pkgs; [
    chezmoi
    discord
    du-dust # disk usage analyzer
    fastfetch
    tokei # code stats
    unimatrix
    wiki-tui # wikipedia
  ];

  programs = {
    # Replacements for some system utils
    bat.enable = true;
    eza.enable = true;
    zoxide.enable = true;
    fzf.enable = true;

    git = {
      enable = true;
      delta.enable = true;
    };
    lazygit.enable = true; # fancy git tui

    librewolf = {
      enable = true;
    };

    spotify-player.enable = true;

    ssh = {
      enable = true;

      # will become deprecated
      enableDefaultConfig = false;

      matchBlocks."*" = {
        forwardAgent = false;
        addKeysToAgent = "yes";
        compression = false;
        serverAliveInterval = 0;
        serverAliveCountMax = 3;
        hashKnownHosts = false;
        userKnownHostsFile = "~/.ssh/known_hosts";
        controlMaster = "no";
        controlPath = "~/.ssh/master-%r@%n:%p";
        controlPersist = "no";
      };
    };

    yazi = {
      enable = true;
      shellWrapperName = "y";
    };
  };
}
