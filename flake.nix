{
  description = "Flake for terraform-gcp-meshplatform";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";
  };

  outputs = { self, nixpkgs }:

  let
    # These tools are pre-installed in github actions, so we can save the time for installing them.
    github_actions_preinstalled = pkgs:
      with pkgs;
      [
        awscli2
        (azure-cli.withExtensions [ azure-cli.extensions.account ])
        nodejs
      ];

    # core packages required in CI and not preinstalled in github actions
    core_packages = pkgs:
      let
        tofu_terraform =
          pkgs.stdenv.mkDerivation {
            name = "tofu-terraform";
            phases = [ "installPhase" ];
            installPhase = ''
              mkdir -p $out/bin
              echo '#!/usr/bin/env sh' > $out/bin/terraform
              echo 'tofu "$@"' >> $out/bin/terraform
              chmod +x $out/bin/terraform
            '';
          };
      in
      with pkgs;
      [
        opentofu
        terragrunt
        tflint
        tfupdate
        terraform-docs
        tofu_terraform
        pre-commit
      ];

    importNixpkgs = system: import nixpkgs { inherit system; };

    defaultShellForSystem = system:
      let
        pkgs = importNixpkgs system;
      in {
        default = pkgs.mkShell {
          name = "terraform-gcp-meshplatform";
          packages = (github_actions_preinstalled pkgs) ++ (core_packages pkgs);
        };
      };

  in {
    devShells = {
      aarch64-darwin = defaultShellForSystem "aarch64-darwin";
      x86_64-darwin = defaultShellForSystem "x86_64-darwin";
      x86_64-linux = defaultShellForSystem "x86_64-linux" // {
        github_actions =
          let
            pkgs = importNixpkgs "x86_64-linux";
          in
          pkgs.mkShell {
            name = "terraform-gcp-meshplatform";
            packages = (core_packages pkgs);
          };
      };
    };
  };
}

