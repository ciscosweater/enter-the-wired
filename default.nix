{ pkgs ? import <nixpkgs> { config.allowUnfree = true; } }:

let
  libs = with pkgs; [
    libGL libgbm libX11 libxcb libxcb-cursor 
    libxkbcommon wayland zlib zstd icu openssl
    alsa-lib libpulseaudio pipewire stdenv.cc.cc.lib
  ];

  runtimeDeps = with pkgs; [
    bash curl git p7zip coreutils
    dotnet-runtime_9
  ];

  justPlayback = pkgs.python3Packages.buildPythonPackage rec {
    pname = "just-playback";
    version = "0.1.8";
    pyproject = true;

    src = pkgs.fetchurl {
      url = "https://files.pythonhosted.org/packages/a4/2d/19ffa29233196f146dd98ffcfd3751b81e43efdd6274f5fac0bdd245038d/just_playback-0.1.8.tar.gz";
      sha256 = "sha256-5ZdHSfEPque7drPx43eaE2knWrF52HWdrifp8ptBA1A=";
    };

    build-system = with pkgs.python3Packages; [ setuptools cffi ];

    dependencies = with pkgs.python3Packages; [ cffi tinytag pydub ];
  };

  pythonEnv = pkgs.python3.withPackages (ps: with ps; [
    pyqt6 psutil beautifulsoup4 requests configobj cryptography 
    pillow numpy zstandard pyyaml gevent vdf urwid 
    pycryptodomex cachetools protobuf typing-extensions setuptools cffi pygame tinytag
  ] ++ [ justPlayback ]);

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
  version = "March";

  src = pkgs.fetchurl {
    url = "https://github.com/LAIN616/ACCELA-DIST/releases/download/${version}/ACCELA-20260323032424-linux-source.tar.gz";
    sha256 = "sha256-sMPcmhbHNjijmIVMp21R5A1TRGDq78YsiIcj3cEOcG8=";
  };

  nativeBuildInputs = [ pkgs.makeWrapper pkgs.copyDesktopItems pkgs.gnused ];
  buildInputs = [ pythonEnv ] ++ libs ++ runtimeDeps;

  desktopItems = [ desktopItem ];

  postPatch = ''
    if [ -f "src/core/tasks/download_slssteam_task.py" ]; then
      sed -i 's|\[script_path, "install"\]|["${pkgs.bash}/bin/bash", script_path, "install"]|g' src/core/tasks/download_slssteam_task.py
    fi
  '';

  installPhase = ''
    mkdir -p $out/bin $out/share/accela $out/share/pixmaps
    cp -r . $out/share/accela/

    find . -name "icon.png" -exec cp {} $out/share/pixmaps/accela.png \;
    [ ! -f "$out/share/pixmaps/accela.png" ] && ln -s ${pkgs.steam}/share/icons/hicolor/48x48/apps/steam.png $out/share/pixmaps/accela.png

    makeWrapper ${pythonEnv}/bin/python3 $out/bin/accela \
      --add-flags "$out/share/accela/src/main.py" \
      --prefix PATH : ${pkgs.lib.makeBinPath runtimeDeps} \
      --prefix LD_LIBRARY_PATH : ${pkgs.lib.makeLibraryPath libs} \
      --set DOTNET_ROOT "${pkgs.dotnet-runtime_9}" \
      --set DOTNET_SYSTEM_GLOBALIZATION_INVARIANT 0

    copyDesktopItems
  '';

  meta = with pkgs.lib; {
    description = "ACCELA - Part of Enter The Wired";
    license = licenses.mit;
    platforms = platforms.linux;
    mainProgram = "accela";
  };
}