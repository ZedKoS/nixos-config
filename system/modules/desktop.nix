{
  config,
  lib,
  pkgs,
  ...
}: let
  sessions = [config.desktop.defaultSession] ++ config.desktop.otherSessions;

  mkSessionIfEnabled = session: value: lib.mkIf (lib.elem session sessions) value;
in {
  config = lib.mkMerge (
    # Common configuration options
    [
      {
        environment.systemPackages = with pkgs; [
          # Utils
          brightnessctl
          playerctl
        ];

        environment.sessionVariables = {
          NIXOS_OZONE_WL = "1";
        };
      }
    ]

    # Session-specific options
    ++ (lib.mapAttrsToList mkSessionIfEnabled {
      xfce = {
        services.xserver = {
          enable = true;

          desktopManager = {
            xterm.enable = false;
            xfce.enable = true;
          };

          xkb.layout = "us";
          xkb.variant = "intl";
        };
      };

      plasma6 = {
        services.desktopManager.plasma6.enable = true;
      };

      hyprland = {
        programs = {
          hyprland = {
            enable = true;
            xwayland.enable = true;
          };
        };

        environment.systemPackages = with pkgs; [
          hyprpicker # color picker

          dunst # notification daemon
          waybar

          # Clipboard
          clipse
          wl-clipboard
        ];
      };
    })
  );
}
