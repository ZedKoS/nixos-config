{ pkgs, username, ...}: {
  imports = [
    ./helix.nix
  ];

  home.packages = with pkgs; [
    neofetch
    chezmoi

    discord
  ];

  programs = {
    # Replacements for some system utils
    bat.enable = true;
    eza.enable = true;
    zoxide.enable = true;
    fzf.enable = true;

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
