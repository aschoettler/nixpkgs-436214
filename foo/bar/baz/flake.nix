{
  description = "A NixOS Configuration";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

  outputs =
    { self, ... }@inputs:
    let
      system_arch = "aarch64-linux";
      pkgs = import inputs.nixpkgs { system = system_arch; };
      opts = import ../../resource.nix { inherit (pkgs) lib; };
    in
    {
      nixosModules.boot-minimal = {
        boot.loader.grub.device = "nodev";
        fileSystems."/" = {
          device = "/dev/disk/by-label/ROOT";
          fsType = "ext4";
        };
      };

      nixosConfigurations.default = inputs.nixpkgs.lib.nixosSystem {
        system = system_arch;
        modules = [
          {
            options.thing = opts;
            config.thing.value = "Some Content";
          }
          self.nixosModules.boot-minimal
        ];
      };
    };

}
