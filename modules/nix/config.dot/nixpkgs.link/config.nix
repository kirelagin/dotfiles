{

  packageOverrides = pkgs_: let pkgs = pkgs_.pkgs; in with pkgs; {

    all = with pkgs; buildEnv {
      name = "userPackages";
      paths = let
                thisDir = builtins.toPath ./.;
                packageFiles = builtins.attrNames (lib.filterAttrs (n: t: t == "regular" && lib.hasPrefix "packages" n) (builtins.readDir thisDir));
                packageSets = map (n: import (builtins.toPath (thisDir + "/" + n)) { pkgs_ = pkgs_; pkgs = pkgs; } ) packageFiles;
                hereSets =  builtins.filter (s: s.condition or true) packageSets;
                userPackages = lib.concatMap (s: s.userPackages) hereSets;
              in userPackages;
      extraOutputsToInstall = [ "man" ];
      pathsToLink = [ "/bin" "/sbin" "/share" ];
    };
  };
}
