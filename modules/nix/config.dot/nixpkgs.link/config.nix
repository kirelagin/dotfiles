{
  packageOverrides = pkgs_: let pkgs = pkgs_.pkgs; in with pkgs; {

    withMan = lib.concatMap (p: [p] ++ lib.optional (p ? man) p.man);

    all = with pkgs; buildEnv {
      name = "userPackages";
      paths = let
                thisDir = builtins.toPath ./.;
                packageFiles = builtins.attrNames (lib.filterAttrs (n: t: t == "regular" && lib.hasPrefix "packages" n) (builtins.readDir thisDir));
                packageSets = map (n: import (builtins.toPath (thisDir + "/" + n)) { pkgs_ = pkgs_; pkgs = pkgs; } ) packageFiles;
                hereSets =  builtins.filter (s: (!(s ? condition)) || s.condition) packageSets;
                userPackages = lib.concatMap (s: s.userPackages) hereSets;
              in withMan userPackages;
    };
  };
}
