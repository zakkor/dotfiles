self: super:

let inherit (self) fetchurl;
in
{
  unstable = import <nixos-unstable> { config = self.config; };

  hubstaff = super.hubstaff.overrideAttrs (old: rec {
    name = "hubstaff-${version}";
    version = "1.5.5-4498311a";

    src = fetchurl {
      url = "https://hubstaff-production.s3.amazonaws.com/downloads/HubstaffClient/Builds/Release/${version}/Hubstaff-${version}.sh";
      sha256 = "1rg37fd6g4h22z3r0by4sjqh4vnbz08rf96bnhwiyzkhj5b23hi7";
    };
  });
}