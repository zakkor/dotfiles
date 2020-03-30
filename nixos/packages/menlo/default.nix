{ stdenv, fetchzip }:

let
  version = "1";
in fetchzip {
  name = "menlo";

  url = "https://www.cufonfonts.com/download/font/menlo";

  postFetch = ''
    mkdir -p $out/share/fonts
    unzip -j $downloadedFile \*.ttf -d $out/share/fonts/truetype
  '';

  sha256 = "1vry0s3jr8bl1gbkf2s50dgihacjynjdc977yyv1yqn4v5jjzrbv";
}