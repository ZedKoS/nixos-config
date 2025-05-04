{
  config,
  lib,
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
        package = null;
      };

      services = {
        hyprpaper = {
          enable = true;
          # settings = {};
        };

        hyprpolkitagent.enable = true;
      };
    };
  });
}
