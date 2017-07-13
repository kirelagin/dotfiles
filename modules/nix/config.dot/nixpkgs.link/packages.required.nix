{ pkgs_, pkgs }:
with pkgs;

{
  name = "required";
  userPackages = [
    cacert
  ];
}
