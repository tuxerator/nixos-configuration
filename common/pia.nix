{ config, pkgs, ... }:
{
  sops.secrets."openvpn/crl" = { };
  sops.secrets."openvpn/ca" = { };
  sops.secrets."openvpn/password" = { };
  sops.templates."swiss-udp.ovpn".content = ''
    client
    dev tun
    proto udp
    remote swiss.privacy.network 1197
    resolv-retry infinite
    nobind
    persist-key
    persist-tun
    cipher aes-256-gcm
    tls-client
    remote-cert-tls server

    <auth-user-pass>
    p1070600
    ${config.sops.placeholder."openvpn/password"}
    </auth-user-pass>
    comp-lzo no
    verb 1
    reneg-sec 0

    <ca>
    ${config.sops.placeholder."openvpn/ca"}
    </ca>

    disable-occ
  '';
  services.openvpn.servers = {
    pia = {
      autoStart = false;
      config = "config ${config.sops.templates."swiss-udp.ovpn".path}";
    };
  };
  environment.systemPackages = with pkgs; [
    networkmanager-openvpn
  ];
}
