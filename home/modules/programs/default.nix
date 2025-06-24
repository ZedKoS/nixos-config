{ pkgs, username, ...}: {
  imports = [
    ./helix.nix
  ];

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

    librewolf = {
      enable = true;
    };

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
