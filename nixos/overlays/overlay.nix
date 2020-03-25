self: super:

let inherit (self)  fetchurl runCommand callPackage;
in
{
  unstable = import <nixos-unstable> { config = self.config; };

  # Overrides
  hubstaff = super.hubstaff.overrideAttrs (old: rec {
    name = "hubstaff-${version}";
    version = "1.5.5-4498311a";

    src = fetchurl {
      url = "https://hubstaff-production.s3.amazonaws.com/downloads/HubstaffClient/Builds/Release/${version}/Hubstaff-${version}.sh";
      sha256 = "1rg37fd6g4h22z3r0by4sjqh4vnbz08rf96bnhwiyzkhj5b23hi7";
    };
  });
  discord = super.discord.overrideAttrs (old: rec {
    version = "0.0.10";
    src = fetchurl {
      url = "https://dl.discordapp.net/apps/linux/${version}/discord-${version}.tar.gz";
      sha256 = "0kx92i8naqr3algmyy3wyzbh8146z7gigxwf1nbpg1gl16wlplaq";
    };
  });
  acme2k = super.plan9port.overrideAttrs(old: {
    src = runCommand "acme2k" {
      srcAcme2k = super.fetchFromGitHub {
        owner = "siacali";
        repo = "acme2k";
        rev = "4dc732aae335254591e28ff3109c54059458e94e";
        sha256 = "065589vfwxqj21zjpsf4nq1zbn7509glzm6qkg3wdpzbmncdqn9z";
      };
      srcPlan9Port = super.fetchFromGitHub {
        owner = "9fans";
        repo = "plan9port";
        rev = "92aa0e13ad8cec37936998a66eb728bfca88d689";
        sha256 = "0z7wkpikmi2qv2v2b5f9ishxjdgnkrdnajk1pdyg5d1qf3nkqwi6";
      };
    } ''
      mkdir $out
      cp -r $srcPlan9Port/* $out
      chmod -R +w $out/src/cmd/acme
      cp -r $srcAcme2k/src/cmd/acme $out/src/cmd
    '';
    postPatch = ''
      # hardcoded path
      substituteInPlace src/cmd/acme/config.h \
        --replace /lib/font/bit/profont/profont-12.font /mnt/font/RobotoMono-Regular/12a/font \
        --replace /lib/font/bit/mntcarlo/mntcarlo.font /mnt/font/RobotoMono-Regular/12a/font
      
      # color scheme
      echo -e "#define ENABLE_PASTELS\n$(cat src/cmd/acme/config.h)" > src/cmd/acme/config.h
      echo -e "#define C_MIX DWhite\n$(cat src/cmd/acme/config.h)" > src/cmd/acme/config.h

      substituteInPlace src/cmd/acme/config.h \
        --replace "#define C_TAGBG			0xFFFFFFFF" "#define C_TAGBG	0x2e3440FF" \
        --replace "#define C_TAGFG			0x000000FF" "#define C_TAGFG	0xD8DEE9FF" \
        --replace "#define C_TAGHLBG		0x999999FF" "#define C_TAGHLBG	0x4C566AFF" \
        --replace "#define C_TAGHLFG		0x000000FF" "#define C_TAGHLFG	0xD8DEE9FF" \
        --replace "#define C_TXTBG			0xFFFFFFFF" "#define C_TXTBG	0x2e3440FF" \
        --replace "#define C_TXTFG			0x000000FF" "#define C_TXTFG	0xD8DEE9FF" \
        --replace "#define C_TXTHLBG		0x999999FF" "#define C_TXTHLBG	0x4C566AFF" \
        --replace "#define C_TXTHLFG		0x000000FF" "#define C_TXTHLFG	0xD8DEE9FF" \
        --replace "#define C_WINBUTTON		0x4d4d4dFF" "#define C_WINBUTTON	0x81A1C1FF" \
        --replace "#define C_COLBUTTON		0x55aaaaFF" "#define C_COLBUTTON	0x4C566AFF" \
        --replace "#define C_TMPBUTTON		0x55aaaaFF" "#define C_TMPBUTTON	0x4C566AFF" \
        --replace "#define C_SCROLLBG		0x999999FF" "#define C_SCROLLBG		0x4C566AFF" \
        --replace "#define C_BUTTON2HL		0x55aaaaFF" "#define C_BUTTON2HL	0x4C566AFF" \
        --replace "#define C_BUTTON3HL		0x55aaaaFF" "#define C_BUTTON3HL	0x4C566AFF"
      
      
      cat src/cmd/acme/config.h
      exit 1
 
      # deprecated flags
      find . -type f \
        -exec sed -i -e 's/_SVID_SOURCE/_DEFAULT_SOURCE/g' {} \; \
        -exec sed -i -e 's/_BSD_SOURCE/_DEFAULT_SOURCE/g' {} \;
      substituteInPlace bin/9c \
        --replace 'which uniq' '${super.which}/bin/which uniq'
    '';
  });
  
  acme2k = super.plan9port.overrideAttrs(old: {
    src = fetchFromGitHub {
    	owner = "prodhe";
    	repo = "plan9port";
    	rev = "";
    	sha256 = "0z7wkpikmi2qv2v2b5f9ishxjdgnkrdnajk1pdyg5d1qf3nkqwi6";
  });
}