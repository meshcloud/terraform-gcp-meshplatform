{ pkgs ? import <nixpkgs> { }, system ? builtins.currentSystem }:

let
  # fake opentofu as terraform so that tools like terraform-docs pre-commit hook (which doesn't have tofu support)
  # fall back to tofu
  tofu_terraform =
    pkgs.stdenv.mkDerivation {
      name = "tofu-terraform";
      phases = [ "installPhase" ];
      installPhase = ''
        mkdir -p $out/bin
        echo '#!/usr/bin/env sh' > $out/bin/terraform
        echo 'tofu $@' > $out/bin/terraform
        chmod +x $out/bin/terraform
      '';
    };

in

pkgs.mkShell {
  NIX_SHELL = "terraform-meshplatform-modules";
  shellHook = ''
    echo starting terraform-meshplatform-modules shell
    terraform -v
    tofu -v
    terraform-docs -v
    pre-commit --version
  '';

  buildInputs = [
    pkgs.pre-commit
    pkgs.opentofu
    pkgs.tflint
    pkgs.terraform-docs

    # fake tofu as terraform
    tofu_terraform
  ];
}
