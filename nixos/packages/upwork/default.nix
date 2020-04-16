{ stdenv, fetchurl, dpkg, wrapGAppsHook
, alsaLib, atk, at-spi2-atk, at-spi2-core, cairo, cups, dbus, expat, fontconfig, freetype
, gdk-pixbuf, glib, gtk3, libnotify, libX11, libXcomposite, libXcursor, libXdamage, libuuid
, libXext, libXfixes, libXi, libXrandr, libXrender, libXtst, nspr, nss, libxcb
, pango, systemd, libXScrnSaver, libcxx, libpulseaudio }:

stdenv.mkDerivation rec {
  name = "upwork-${version}";
  version = "5.3.3-883";

  src = fetchurl {
    url = https://updates-desktopapp.upwork.com/binaries/v5_3_3_883_1f817bc1fefd44e7/upwork_5.3.3.883_amd64.deb;
    sha256 = "072zns79w4h46bvbj23rvr8i12sf2l378ry0z3hchwcimkrph9wx";
  };

  nativeBuildInputs = [ 
    dpkg
    wrapGAppsHook
  ];

  dontWrapGApps = true;

  libPath = stdenv.lib.makeLibraryPath [
    libcxx systemd libpulseaudio
    stdenv.cc.cc alsaLib atk at-spi2-atk at-spi2-core cairo cups dbus expat fontconfig freetype
    gdk-pixbuf glib gtk3 libnotify libX11 libXcomposite libuuid
    libXcursor libXdamage libXext libXfixes libXi libXrandr libXrender
    libXtst nspr nss libxcb pango systemd libXScrnSaver
   ];

  unpackPhase = ''
    dpkg-deb -x ${src} ./
  '';

  installPhase = ''
    mv usr $out
    mv opt $out
    sed -e "s|/opt/|$out/opt/|g" -i $out/share/applications/upwork.desktop
    patchelf --set-interpreter ${stdenv.cc.bintools.dynamicLinker} \
        $out/opt/Upwork/upwork

    wrapProgram $out/opt/Upwork/upwork \
        "''${gappsWrapperArgs[@]}" \
        --prefix XDG_DATA_DIRS : "${gtk3}/share/gsettings-schemas/${gtk3.name}/" \
        --prefix LD_LIBRARY_PATH : ${libPath}
  '';
}