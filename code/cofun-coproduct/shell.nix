with (import <nixpkgs> {}).pkgs;
let modifiedHaskellPackages = haskellPackages.override {
      overrides = self: super: {
        cofun-pairing = self.callPackage ../cofun-pairing {};
        cofun-coproduct = self.callPackage ./. {};
      };
    };
in modifiedHaskellPackages.cofun-coproduct.env
