{ pkgs, ...}: {
  home.packages = with pkgs; [
    clang

    # Rust
    rustc
    cargo
    rustfmt
    rust-analyzer

  ];
}
