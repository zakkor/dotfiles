{
	pkgs ? import <nixpkgs> {}
  , runCommand
  , fetchFromGitHub
}:

pkgs.plan9port.overrideAttrs(oldAttrs: {
    src = runCommand "acme2k" {
      srcAcme2k = fetchFromGitHub {
        owner = "siacali";
        repo = "acme2k";
        rev = "4dc732aae335254591e28ff3109c54059458e94e";
        sha256 = "065589vfwxqj21zjpsf4nq1zbn7509glzm6qkg3wdpzbmncdqn9z";
      };
      srcPlan9Port = fetchFromGitHub {
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
    
    patches = [
      ./controlS-Put.patch
    ];

    postPatch = ''
    	# disable bartflag
    	substituteInPlace src/cmd/acme/config.h \
    		--replace "int bartflag			= TRUE;" "int bartflag			= FALSE;"
    
      # hardcoded path
      substituteInPlace src/cmd/acme/config.h \
        --replace /lib/font/bit/profont/profont-12.font /mnt/font/RobotoMono-Regular/12a/font \
        --replace /lib/font/bit/mntcarlo/mntcarlo.font /mnt/font/RobotoMono-Regular/12a/font
      
      # color scheme
      echo -e "#define ENABLE_PASTELS\n$(cat src/cmd/acme/config.h)" > src/cmd/acme/config.h
      echo -e "#define C_MIX DWhite\n$(cat src/cmd/acme/config.h)" > src/cmd/acme/config.h

      substituteInPlace src/cmd/acme/config.h \
        --replace "#define C_TAGBG			0xFFFFFFFF" "#define C_TAGBG	DPalebluegreen" \
        --replace "#define C_TAGFG			0x000000FF" "#define C_TAGFG	0x000000FF" \
        --replace "#define C_TAGHLBG		0x999999FF" "#define C_TAGHLBG	DPalegreygreen" \
        --replace "#define C_TAGHLFG		0x000000FF" "#define C_TAGHLFG	0x000000FF" \
        --replace "#define C_TXTBG			0xFFFFFFFF" "#define C_TXTBG	DPaleyellow" \
        --replace "#define C_TXTFG			0x000000FF" "#define C_TXTFG	0x000000FF" \
        --replace "#define C_TXTHLBG		0x999999FF" "#define C_TXTHLBG	DDarkyellow" \
        --replace "#define C_TXTHLFG		0x000000FF" "#define C_TXTHLFG	0x000000FF" \
        --replace "#define C_WINBUTTON		0x4d4d4dFF" "#define C_WINBUTTON	DPurpleblue" \
        --replace "#define C_COLBUTTON		0x55aaaaFF" "#define C_COLBUTTON	DPurpleblue" \
        --replace "#define C_TMPBUTTON		0x55aaaaFF" "#define C_TMPBUTTON	DMedblue" \
        --replace "#define C_SCROLLBG		0x999999FF" "#define C_SCROLLBG		DYellowgreen" \
        --replace "#define C_BUTTON2HL		0x55aaaaFF" "#define C_BUTTON2HL	0xAA0000FF" \
        --replace "#define C_BUTTON3HL		0x55aaaaFF" "#define C_BUTTON3HL	0x006600FF"

      # deprecated flags
      find . -type f \
        -exec sed -i -e 's/_SVID_SOURCE/_DEFAULT_SOURCE/g' {} \; \
        -exec sed -i -e 's/_BSD_SOURCE/_DEFAULT_SOURCE/g' {} \;
      substituteInPlace bin/9c \
        --replace 'which uniq' '${pkgs.which}/bin/which uniq'
    '';
})
