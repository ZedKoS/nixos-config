{
  config,
  lib,
  pkgs,
  username,
  ...
}: let
  cfg = config.desktop;
  sessions = [cfg.defaultSession] ++ cfg.otherSessions;

  mkSessionIfEnabled = session: value: lib.mkIf (lib.elem session sessions) value;
in {
  config = lib.mkMerge (lib.mapAttrsToList mkSessionIfEnabled {
    hyprland = {
      # wayland.windowManager.hyprland = {
      #   enable = true;
      #   package = null;
      # };

      # xdg.portal.configPackages = [
      #   pkgs.xdg-desktop-portal-hyprland
      #   pkgs.xdg-xdg-desktop-portal-gtk
      # ];

      home.packages = with pkgs; [
        hyprpaper
        hyprpolkitagent
      ];

      services = {
        hyprpaper = {
          enable = true;

          settings = let
            wp = "/home/${username}/Wallpapers/MistyTrees.jpg";
          in {
            preload = [wp];
            wallpaper = [
              ",${wp}"
            ];
          };
        };

        hyprpolkitagent.enable = true;
      };
    };
  });
}
