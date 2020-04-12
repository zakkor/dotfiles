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
  
  # Packages
  acme2k = callPackage ../packages/acme2k {};
  menlo = callPackage ../packages/menlo {};
  upwork = callPackage ../packages/upwork {};
}
