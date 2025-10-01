{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.desktop;
  sessions = [cfg.defaultSession] ++ cfg.otherSessions;

  mkSessionIfEnabled = session: value: lib.mkIf (lib.elem session sessions) value;
in {
  config = lib.mkMerge (lib.mapAttrsToList mkSessionIfEnabled {
    hyprland = {
      wayland.windowManager.hyprland = {
        enable = true;

        systemd.enable = true;
        systemd.variables = ["--all"];

        extraConfig = ''
          source = ~/.config/hypr/hyprland_extra.conf
        '';
      };

      home.packages = with pkgs; [
        hyprpicker # color picker
        hyprpaper # wallpaper
        wlsunset # gamma adjustment
      ];

      services = {
        # Wallpaper
        hyprpaper.enable = true;

        hyprpolkitagent.enable = true;

        # Day/night gamma adjustment
        wlsunset = {
          enable = true;
          latitude = 45;
          longitude = 0;
        };
      };

      programs = {
        rofi = {
          enable = true;
          plugins = [pkgs.rofi-calc pkgs.rofi-emoji];

          modes = ["drun" "run" "emoji" "ssh" "calc"];

          terminal = "${pkgs.kitty}/bin/kitty";
        };

        wlogout.enable = true;
      };
    };
  });
}
