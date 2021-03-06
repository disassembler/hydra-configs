{ }:

let
  pkgs = import <nixpkgs> {};
in with (import ../lib.nix { inherit pkgs; });
with pkgs.lib;
let
  defaults = globalDefaults // {
    nixexprinput = "nixos-configs";
    nixexprpath = "release.nix";
    checkinterval = 600;
  };
  nixos-configs = defaults // {
    description = "nixos-configs";
    inputs = {
      nixos-configs = mkFetchGithub "https://github.com/disassembler/network master";
      nixpkgs-unstable = mkFetchGithub "https://github.com/nixos/nixpkgs-channels.git nixos-unstable";
      nixdarwin-unstable = mkFetchGithub "https://github.com/LnL7/nix-darwin.git master";
      nixpkgs-stable = mkFetchGithub "https://github.com/nixos/nixpkgs-channels.git nixos-18.09";
      nixpkgs = mkFetchGithub "https://github.com/nixos/nixpkgs-channels.git nixos-18.09";
    };
  };
  jobsetsAttrs = { inherit nixos-configs; };
in {
  jobsets = pkgs.writeText "spec.json" (builtins.toJSON jobsetsAttrs);
}
