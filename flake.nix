{
  description = "Flake template to demonstrate nixos/nixpkgs/issues/436214";

  outputs = inputs: {
    templates = {
      default = {
        path = ./.;
        description = "A Template";
      };
    };
  };
}
