{
  config,
  lib,
  ...
}: let
  displayManager = config.desktop.displayManager;
in {
  config = lib.mkMerge (
    [
      {
        # This only works for certain DMs, see configuration.nix(5)
        services.displayManager.defaultSession = config.desktop.defaultSession;
      }
    ]
    ++ (lib.mapAttrsToList (dm: value: lib.mkIf (dm == displayManager) value) {
      ly = {
        services.displayManager = {
          enable = true;
          ly.enable = true;

          ly.settings = {
            animation = "matrix";
            box_title = "< Login to NixOS >";
          };
        };
      };

      sddm = {
        services.displayManager = {
          enable = true;
          sddm.enable = true;
          sddm.wayland.enable = true;
        };
      };
    })
  );
}
