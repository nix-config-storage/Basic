{
  description = "Declarative set of imperative steps for cleaning system state";

  inputs = {
  devenv-root = {
    url = "file+file:///home/nixos/basic";
    flake = false;
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:cachix/devenv-nixpkgs/rolling";
    devenv.url = "github:cachix/devenv";
    nix2container.url = "github:nlewo/nix2container";
    nix2container.inputs.nixpkgs.follows = "nixpkgs";
    mk-shell-bin.url = "github:rrbutani/nix-mk-shell-bin";
  };

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
    flake-registry = "./init/res/files/flake-registry.json";

  NIX_PATH = "nixpkgs=flake:/home/nixos/basic/"; 
  };

  outputs = inputs@{ flake-parts, devenv-root, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.devenv.flakeModule
      ];
      systems = [ "x86_64-linux" ];

      perSystem = { config, self', inputs', pkgs, system, ... }: {
        # Per-system attributes can be defined here. The self' and inputs'
        # module parameters provide easy access to attributes of the same
        # system.
	# Equivalent to  inputs'.nixpkgs.legacyPackages.hello;
#apps.default = devenv.
        packages.default = pkgs.devenv;
         
        devenv.shells.default = {
          name = "my-project";

          imports = [
            # This is just like the imports in devenv.nix.
            # See https://devenv.sh/guides/using-with-flake-parts/#import-a-devenv-module
             ./devenv.nix
          ];

          # https://devenv.sh/reference/options/
          packages = [
 config.packages.default 

];
#apps = { 
#default = devShells.default;
#};

          enterShell = ''
            hello
          '';
          processes.hello.exec = "hello";
        };

      };
      flake = {
        # The usual flake attributes can be defined here, including system-
        # agnostic ones like nixosModule and system-enumerating ones, although
        # those are more easily expressed in perSystem.

      };
    };
}
