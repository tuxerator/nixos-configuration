{ config, pkgs, ... }:
{
  sops.secrets."openvpn/crl" = { };
  sops.secrets."openvpn/ca" = { };
  sops.templates."swiss-udp.ovpn".content = ''
    auth-user-pass
    client
    dev tun
    proto udp
    remote swiss.privacy.network 1197
    resolv-retry infinite
    nobind
    persist-key
    persist-tun
    cipher aes-256-cbc
    auth sha256
    tls-client
    remote-cert-tls server

    auth-user-pass
    compress
    verb 1
    reneg-sec 0

    crl-verify ${config.sops.placeholder."openvpn/crl"}
    ca ${config.sops.placeholder."openvpn/ca"}

    disable-occ
  '';
  services.openvpn.servers = {
    pia = {
      autoStart = true;
      config = "path ${config.sops.templates."swiss-udp.ovpn".path}";
    };
  };
}
