{
  pkgs ? import <nixpkgs> {}
  , runCommand
  , fetchFromGitHub
}:

# Ideas for patches:
# - Ability to configure certain key-combos to execute a command (should use a keybinding daemon (sxhkd) and acmefocused (https://godoc.org/github.com/fhs/acme-lsp/cmd/acmefocused))
# - Ctrl+X with no selection selects whole line then cuts

pkgs.plan9port.overrideAttrs(oldAttrs: {
    src = runCommand "acme" {
      srcAcme2k = fetchFromGitHub {
        owner = "karahobny";
        repo = "acme2k";
        rev = "3cac97e229c07a4a5fb3e6ae5e9115202934f310";
        sha256 = "1sswvyivqfib2xgajbjkf7rigmj7wz12yphacwfsz0rr1wyzjivb";
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
      ./spaces.patch
      ./colorBlending.patch
      ./indentSpaces.patch
      ./controlS-Put.patch
    ];

    postPatch = ''
      cat > src/cmd/acme/config.h <<EOF
/*
 *  fontnames-array takes two fonts, first one
 *  it treats as a proportional-width font and uses
 *  everywhere possible and as a main UI font, while
 *  the second font it treats as a fixed-width font,
 *  changeable to any text window by executing "Font"
 *  from tag window.
 *
 *  Note: "Font" can also be executed
 *  with arguments with any "fontsrv -p ." approved
 *  fonts, thus allowing you to experiment with font
 *  sizes and whether you want anti-aliasing or not.
 */

char *fontnames[2] = {
	"/mnt/font/RobotoMono-Regular/12a/font",
	"/mnt/font/RobotoMono-Regular/12a/font"
};

/*
 *  globalautoindent tries to guess where to
 *  indent by the context of the previous line.
 *
 *  comes highly suggested.
 */

int globalautoindent	= TRUE;

/*
 *  swapping scroll buttons makes B1 scroll down
 *  instead of up and B2 up instead of down
 */

int	swapscrollbuttons	= FALSE;

/*
 *  bartflag triggers quote unquote experimental
 *  mode, in which instead of mouse following focus
 *  from window to window etc. it in fact, does not.
 *
 *  comes highly suggested.
 */

int bartflag			= FALSE;

/*
 *  colors-constants. now let me take a minute to explain
 *  them. C_TAGBG/FG/HLBG/HLFG are respectively your tag
 *  windows background, foreground, highlighted back- and
 *  foreground color. The same exact applies to C_TXT*-
 *  variants of the same constant just in this case it handles
 *  the colorscheme of the text window.
 *
 *  C_WINBUTTON is the button which you adjust your columns
 *  position with. C_COLBUTTON represents a separate text
 *  windows button. C_TMPBUTTON is the so-called "dirty"
 *  or "unclean" -marker aka notifying the file as modified put
 *  in the middle of C_COLBUTTON. C_SCROLLBG is plain and simple
 *  your scrollbars background color.
 *
 *  the last two defines are for defining the color of the specific
 *  buttons highlight background.
 */

#define ENABLE_PASTELS
#define C_MIX DWhite

#define C_TAGBG			DPalebluegreen
#define C_TAGFG			0x000000FF
#define C_TAGHLBG		DPalegreygreen
#define C_TAGHLFG		0x000000FF

#define C_TXTBG			DPaleyellow
#define C_TXTFG			0x000000FF
#define C_TXTHLBG		DDarkyellow
#define C_TXTHLFG		0x000000FF

#define C_WINBUTTON		DPurpleblue
#define C_COLBUTTON		DPurpleblue
#define C_TMPBUTTON		DMedblue
#define C_SCROLLBG		DYellowgreen

#define C_BUTTON2HL		0xAA0000FF
#define C_BUTTON3HL		0x006600FF
EOF

      # deprecated flags
      find . -type f \
        -exec sed -i -e 's/_SVID_SOURCE/_DEFAULT_SOURCE/g' {} \; \
        -exec sed -i -e 's/_BSD_SOURCE/_DEFAULT_SOURCE/g' {} \;

      substituteInPlace bin/9c \
        --replace 'which uniq' '${pkgs.which}/bin/which uniq'
    '';
})
