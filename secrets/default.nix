{ ... }:
{
  sops.defaultSopsFile = ./secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "/var/lib/sops-nix/carrie-root.txt";
  sops.age.generateKey = true;
}
