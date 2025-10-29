# Problem

The commands `nixos-option` and `nixos-rebuild` don't work for flake.nix files unless they are in the root of the git repository. This differs from the behavior of commands like `nix build`. Moreover, explicitly specifying the flakeref path with `-F` doesn't work.

# Steps to Reproduce

**Failure for flake in a git repo**

In any temporary directory, run the following:

```sh
git clone https://github.com/aschoettler/nixpkgs-436214.git .
pushd foo/bar/baz
nix flake check . && echo "Check Succeeded"
nix build .#nixosConfigurations.default.config.system.build.toplevel && echo "Build Succeeded"
nixos-rebuild --flake .#default build && echo "nixos-rebuild build OK"
nixos-rebuild --flake .#default repl || echo "❌ nixos-rebuild repl FAILED"
popd
```

**Failure for flake not in a git repo**

In an empty directory, run the following:

```sh
nix flake init -t 'github:aschoettler/nixpkgs-436214#default'
pushd bar/baz
nix flake check . && echo "Check Succeeded"
nix build .#nixosConfigurations.default.config.system.build.toplevel && echo "Build Succeeded"
nixos-rebuild --flake .#default build || echo "nixos-rebuild build OK"
nixos-rebuild --flake .#default repl || echo "❌ nixos-rebuild repl FAILED"
popd
```
