{ inputs, ... }:
{
  additions = _final: _prev: { };

  modifications = _final: _prev: { };

  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.stdenv.hostPlatform.system;
      config = {
        allowUnfree = true;
        # pnpm-10.29.2 is pinned for electron-based apps that haven't
        # migrated past the 10.29.3 breaking change. Remove this once
        # nixpkgs drops the pnpm_10_29_2 variant.
        permittedInsecurePackages = [
          "pnpm-10.29.2"
        ];
      };
    };
  };
}
