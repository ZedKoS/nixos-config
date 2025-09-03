{ pkgs, ...}: {
  home.packages = with pkgs; [
    clang

    # Rust
    rustup # includes rustfmt and rust-analyzer
  ];
}
