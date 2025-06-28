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
      addKeysToAgent = "yes";
    };

    yazi = {
      enable = true;
      shellWrapperName = "y";
    };
  };

  stylix.targets.librewolf.profileNames = [ username ];
}
