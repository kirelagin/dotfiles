{ pkgs_, pkgs }:
with pkgs;

{
  name = "linux";
  condition = stdenv.isLinux;
  userPackages = [
                    gimp
  kde5.applications.spectacle
        gitAndTools.qgit
                    qutebrowser
                    xsel
                    zathura
  ];
}
