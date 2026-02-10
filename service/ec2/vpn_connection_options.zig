const VpnTunnelBandwidth = @import("vpn_tunnel_bandwidth.zig").VpnTunnelBandwidth;
const TunnelInsideIpVersion = @import("tunnel_inside_ip_version.zig").TunnelInsideIpVersion;
const TunnelOption = @import("tunnel_option.zig").TunnelOption;

/// Describes VPN connection options.
pub const VpnConnectionOptions = struct {
    /// Indicates whether acceleration is enabled for the VPN connection.
    enable_acceleration: ?bool,

    /// The IPv4 CIDR on the customer gateway (on-premises) side of the VPN
    /// connection.
    local_ipv_4_network_cidr: ?[]const u8,

    /// The IPv6 CIDR on the customer gateway (on-premises) side of the VPN
    /// connection.
    local_ipv_6_network_cidr: ?[]const u8,

    /// The type of IPv4 address assigned to the outside interface of the customer
    /// gateway.
    ///
    /// Valid values: `PrivateIpv4` | `PublicIpv4` | `Ipv6`
    ///
    /// Default: `PublicIpv4`
    outside_ip_address_type: ?[]const u8,

    /// The IPv4 CIDR on the Amazon Web Services side of the VPN connection.
    remote_ipv_4_network_cidr: ?[]const u8,

    /// The IPv6 CIDR on the Amazon Web Services side of the VPN connection.
    remote_ipv_6_network_cidr: ?[]const u8,

    /// Indicates whether the VPN connection uses static routes only. Static routes
    /// must be
    /// used for devices that don't support BGP.
    static_routes_only: ?bool,

    /// The transit gateway attachment ID in use for the VPN tunnel.
    transport_transit_gateway_attachment_id: ?[]const u8,

    /// The configured bandwidth for the VPN tunnel. Represents the current
    /// throughput capacity setting for the tunnel connection. `standard` tunnel
    /// bandwidth supports up to 1.25 Gbps per tunnel while `large`
    /// supports up to 5 Gbps per tunnel. If no tunnel bandwidth was specified for
    /// the connection, `standard` is used as the default value.
    tunnel_bandwidth: ?VpnTunnelBandwidth,

    /// Indicates whether the VPN tunnels process IPv4 or IPv6 traffic.
    tunnel_inside_ip_version: ?TunnelInsideIpVersion,

    /// Indicates the VPN tunnel options.
    tunnel_options: ?[]const TunnelOption,
};
