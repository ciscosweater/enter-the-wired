{ pkgs ? import <nixpkgs> { config.allowUnfree = true; } }:

pkgs.mkShell {
  packages = with pkgs; [
    bash
    coreutils
    curl
    gh
    git
    gnutar
    p7zip
  ];

  shellHook = ''
    echo "--- Enter The Wired ---"
    echo "Tools ready for ACCELA release packaging and script maintenance."
  '';
}
