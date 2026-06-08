{
  lib,
  appimageTools,
  fetchurl,
}:
let
  pname = "accela";
  version = "20260524150213";

  src = fetchurl {
    url = "https://github.com/ciscosweater/enter-the-wired/releases/download/latest/deps.tar.gz";
    hash = "sha256-Zu7ES0ecHIiUEcHZJZ+fBNqXIlz9BCBtWgmvBhd6eSY=";
    downloadToTemp = true;
    postFetch = ''
      tar -xf "file" "bin/ACCELA.AppImage"
      install -m 444 "bin/ACCELA.AppImage" "$out"
    '';
  };

  appimageContents = appimageTools.extract { inherit pname version src; };
in
appimageTools.wrapType2 {
  inherit pname version src;
  extraPkgs =
    pkgs: with pkgs; [
      icu
      xcb-util-cursor
      zstd
    ];

  extraInstallCommands = ''
    install -m 444 -D "${appimageContents}/accela.png" "$out/share/pixmaps/accela.png"
    install -m 444 -D "${appimageContents}/ACCELA.desktop" "$out/share/applications/accela.desktop"
    substituteInPlace $out/share/applications/accela.desktop \
      --replace-fail 'Exec=run.sh' 'Exec=accela'
  '';

  meta = with lib; {
    description = "ACCELA AppImage package for Enter The Wired";
    license = licenses.mit;
    platforms = platforms.linux;
    mainProgram = "accela";
  };
}
