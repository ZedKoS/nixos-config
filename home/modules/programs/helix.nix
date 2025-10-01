{pkgs, ...}: {
  programs.helix = {
    enable = true;

    defaultEditor = true;

    extraPackages = [
      pkgs.marksman
    ];
  };
}
