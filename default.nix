{ pkgs ? import <nixpkgs> { config.allowUnfree = true; } }:

let
  version = "20260512222534";

  desktopItem = pkgs.makeDesktopItem {
    name = "accela";
    exec = "accela";
    icon = "accela";
    comment = "ACCELA - Steam Library Manager";
    desktopName = "ACCELA";
    categories = [ "Game" "Utility" ];
    terminal = false;
  };
in
pkgs.stdenv.mkDerivation rec {
  pname = "accela";
  inherit version;

  src = pkgs.fetchurl {
    url = "https://github.com/ciscosweater/enter-the-wired/releases/download/${version}/ACCELA-${version}-linux.tar.gz";
    hash = "sha256-ID4snD0Dh31MZhowuJZ2Jf7rXoO9pRfpPuv30jDde4w=";
  };

  nativeBuildInputs = [ pkgs.copyDesktopItems pkgs.makeWrapper ];

  desktopItems = [ desktopItem ];

  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    unpack_dir="$TMPDIR/accela"
    mkdir -p "$unpack_dir" "$out/bin" "$out/share/accela" "$out/share/pixmaps"
    tar -xzf "$src" -C "$unpack_dir"

    install -Dm755 "$unpack_dir/bin/ACCELA.AppImage" "$out/share/accela/ACCELA.AppImage"
    install -Dm644 "$unpack_dir/bin/accela.png" "$out/share/pixmaps/accela.png"

    makeWrapper ${pkgs.appimage-run}/bin/appimage-run "$out/bin/accela" \
      --add-flags "$out/share/accela/ACCELA.AppImage"

    copyDesktopItems

    runHook postInstall
  '';

  meta = with pkgs.lib; {
    description = "ACCELA AppImage package for Enter The Wired";
    license = licenses.mit;
    platforms = platforms.linux;
    mainProgram = "accela";
  };
}
