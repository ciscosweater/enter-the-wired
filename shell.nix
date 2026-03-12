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

  pythonEnv = pkgs.python3.withPackages (ps: with ps; [
    pyqt6 psutil beautifulsoup4 requests configobj cryptography 
    pillow numpy zstandard pyyaml gevent vdf urwid 
    pycryptodomex cachetools protobuf typing-extensions setuptools cffi pygame
  ]);
in
pkgs.mkShell {
  nativeBuildInputs = [ pkgs.pkg-config ];

  buildInputs = [ pythonEnv ] ++ libs ++ runtimeDeps;

  shellHook = ''
    export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath libs}:$LD_LIBRARY_PATH"
    export QT_QPA_PLATFORM_PLUGIN_PATH="${pkgs.qt6.qtbase}/lib/qt-6/plugins"
    export QT_XKB_CONFIG_ROOT="${pkgs.xkeyboard_config}/share/X11/xkb"
    export DOTNET_ROOT="${pkgs.dotnet-runtime_9}"
    export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=0

    echo "--- Enter The Wired ---"
  '';
}
