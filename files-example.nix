{ nixpkgs, config, files, lib, ... }:

[
  {
    path_ = "README.md";
    drv =
      pkgs.writeText "README.md"
        # markdown
        ''
          # Practical Project

          Clear documentation
        '';
  }
  {
    path_ = ".gitignore";
    drv = pkgs.writeText ".gitignore" ''
      result
    '';
  }
] 
