{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
flake-parts.url = "github:hercules-ci/flake-parts";
files.url = "github:mightyiam/files";

  };

  outputs = inputs@{ self, nixpkgs, flake-parts, files ... }:
  # https://flake.parts/module-arguments.html
  flake-parts.lib.mkFlake { inherit inputs; } (top@{ config, withSystem, moduleWithSystem, ... }: {
    imports = [
      # Optional: use external flake logic, e.g.
      # inputs.foo.flakeModules.default
 inputs.files.flakeModules.default
./files-example.nix
];
    flake = {
      # Put your original flake attributes here.
    };
    systems = [
      # systems for which you want to build the `perSystem` attributes
      "x86_64-linux"
      # ...
    ];
    perSystem = { config, pkgs, ... }: {
      # Recommended: move all package definitions here.
      # e.g. (assuming you have a nixpkgs input)
      # packages.foo = pkgs.callPackage ./foo/package.nix { };
      # packages.bar = pkgs.callPackage ./bar/package.nix {
      #   foo = config.packages.foo;
      # };
    };
  });


    packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

    packages.x86_64-linux.default = self.packages.x86_64-linux.default;
  };
}
