{ stdenv, fetchurl, dpkg, wrapGAppsHook
, alsaLib, atk, at-spi2-atk, at-spi2-core, cairo, cups, dbus, expat, fontconfig, freetype
, gdk-pixbuf, glib, gtk3, libnotify, libX11, libXcomposite, libXcursor, libXdamage, libuuid
, libXext, libXfixes, libXi, libXrandr, libXrender, libXtst, nspr, nss, libxcb
, pango, systemd, libXScrnSaver, libcxx, libpulseaudio }:

stdenv.mkDerivation rec {
  name = "upwork-${version}";
  version = "5.3.3";

  src = fetchurl {
    url = https://updates-desktopapp.upwork.com/binaries/v5_3_3_862_0gofuuatmjqd0n86/upwork_5.3.3.862_amd64.deb;
    sha256 = "0pplz41kp1l7nyw9kmf0p608p2nx9iy3b0i2dss8pkxmilb3x714";
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
    sed -e "s|/usr/|$out/|g" -i $out/bin/upwork
    sed -e "s|/usr/|$out/|g" -i $out/share/menu/upwork
    patchelf --set-interpreter ${stdenv.cc.bintools.dynamicLinker} \
        $out/share/upwork/upwork

    wrapProgram $out/share/upwork/upwork \
        "''${gappsWrapperArgs[@]}" \
        --prefix XDG_DATA_DIRS : "${gtk3}/share/gsettings-schemas/${gtk3.name}/" \
        --prefix LD_LIBRARY_PATH : ${libPath}
  '';
}