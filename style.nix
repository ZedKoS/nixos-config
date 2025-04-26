{
  config,
  lib,
  pkgs,
  stylix,
  ...
}: {
  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";

  # Wallpaper
  # stylix.image = null;
  stylix.imageScalingMode = "fill";

  # stylix.cursor = null;

  stylix.polarity = "dark";

  stylix.fonts = rec {
    sizes = {
      applications = 11;
      desktop = 11;
      popups = 10;
      terminal = 11;
    };

    # Nobody likes serif.
    serif = sansSerif;

    sansSerif = {
      package = pkgs.ubuntu_font_family;
      name = "Ubuntu Sans";
    };

    monospace = {
      # Why not use a nerd font?
      # Patched fonts don't work well in kitty without some hacks, and kitty
      # already handles nerd symbols anyway, so just use a simple font.
      package = pkgs.fira-code;
      name = "Fira Code";
    };

    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };
  };

  # stylix.iconTheme = {
  #   enable = true;
  #   package = pkgs.papirus-icon-theme;
  # };
 
}
