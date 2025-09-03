{ pkgs, ...}: {
  home.packages = with pkgs; [
    clang

    # Rust
    rustup
    rustfmt
    rust-analyzer

  ];
}
