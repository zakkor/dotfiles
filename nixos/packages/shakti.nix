{ stdenv
, fetchurl
, unzip
, autoPatchelfHook
}:

stdenv.mkDerivation rec {
  name = "shakti";
  version = "2020.03.15";
  src = fetchurl {
    url = "https://shakti.com/linux/k.zip";
    sha256 = "1fbaardv6z53xalnzi5rmvc6fywyb7d0yj8nhwhg7pxv3l4q448w";
    curlOpts = "-e https://shakti.com/downloads/";
  };

  nativeBuildInputs = [
    unzip
    autoPatchelfHook
  ];

  unpackPhase = ''
    unzip $src
  '';

  installPhase = ''
    install -m755 -D k $out/bin/k
  '';

  meta = with stdenv.lib; {
    homepage = http://shakti.com/;
    description = "an implementation of the K8 language, an APL variant.";
    license = licenses.unfree;
    platforms = platforms.linux;
    maintainers = [ zakkor ];
  };
}
