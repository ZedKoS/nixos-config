{
  config,
  lib,
  ...
}: let
  displayManager = config.desktop.displayManager;
in {
  config = lib.mkMerge (
    lib.mapAttrsToList (dm: value: lib.mkIf (dm == displayManager) value) {
      ly = {
        services.displayManager = {
          ly.enable = true;

          ly.settings = {
            animation = "matrix";
            box_title = "< Login to NixOS >";
          };

          defaultSession = config.desktop.defaultSession;
        };
      };

      sddm = {
        services.displayManager.sddm = {
          enable = true;
          wayland.enable = true;
        };
      };
    }
  );
}
