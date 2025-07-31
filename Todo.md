part 1 
export env vars for -
flake-registry - file:///
NIX_PATH
NIXPKGS-CONFIG

import from derivation false


----
convert nix.conf to either nix.settings/nix.options or whichever it was, or devenv.yaml, or both 

check and list vars to unset
list sysd services to stop

clone all etc files, then select keepers, and edits; copy them here
rm -rf /etc 
restore/replace with backups from this flake
----

nix profile install --inputs-from ./

or 

in the devenv 
somehow set the active/linked or used version of a cmd to
pkgs.the-package-you-want

this is "obviously" different from just installing it, but make sure you use that one

replace any core deps/libs


nix-collect-garbage -d
see whats left, you should have a pretty clean env, good enough for now.

later on you should add this nuttiness:

part 2 recurse:

from here reinit devenv with added stdenv, and build tools

+ a function that uses this minimal "profile",
opens a new nix store (tmpfs),
installs itself as the only profile in that nix store
deletes the previous one, 
reinit nix store's original location,
move deps, remove tmp store

-----

call this set-point/clean-env/whatever, 
return to this state between any mass rebuilds,
any security critical builds (kernel, sysd, drivers, modules)
or when updating nixpkgs versions
