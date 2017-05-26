{ pkgs_, pkgs }:
with pkgs;

{
  name = "macos";
  condition = stdenv.isDarwin;
  userPackages = [
  #                      cacert
  #                    python2
  #                    python3
  ];
}
