{ lib, ... }:
{
  value = lib.mkOption {
    type = lib.types.str;
    default = "";
    description = "A Value";
  };
}
