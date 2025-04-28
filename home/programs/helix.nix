{pkgs, ...}: {
  stylix.targets.helix.enable = false;

  programs.helix = {
    enable = true;

    defaultEditor = true;

    extraPackages = [
      pkgs.marksman
    ];
  };
}
