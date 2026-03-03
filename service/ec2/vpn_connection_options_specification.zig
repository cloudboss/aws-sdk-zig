const VpnTunnelBandwidth = @import("vpn_tunnel_bandwidth.zig").VpnTunnelBandwidth;
const TunnelInsideIpVersion = @import("tunnel_inside_ip_version.zig").TunnelInsideIpVersion;
const VpnTunnelOptionsSpecification = @import("vpn_tunnel_options_specification.zig").VpnTunnelOptionsSpecification;

/// Describes VPN connection options.
pub const VpnConnectionOptionsSpecification = struct {
    /// Indicate whether to enable acceleration for the VPN connection.
    ///
    /// Default: `false`
    enable_acceleration: ?bool = null,

    /// The IPv4 CIDR on the customer gateway (on-premises) side of the VPN
    /// connection.
    ///
    /// Default: `0.0.0.0/0`
    local_ipv_4_network_cidr: ?[]const u8 = null,

    /// The IPv6 CIDR on the customer gateway (on-premises) side of the VPN
    /// connection.
    ///
    /// Default: `::/0`
    local_ipv_6_network_cidr: ?[]const u8 = null,

    /// The type of IP address assigned to the outside interface of the customer
    /// gateway device.
    ///
    /// Valid values: `PrivateIpv4` | `PublicIpv4` | `Ipv6`
    ///
    /// Default: `PublicIpv4`
    outside_ip_address_type: ?[]const u8 = null,

    /// The IPv4 CIDR on the Amazon Web Services side of the VPN connection.
    ///
    /// Default: `0.0.0.0/0`
    remote_ipv_4_network_cidr: ?[]const u8 = null,

    /// The IPv6 CIDR on the Amazon Web Services side of the VPN connection.
    ///
    /// Default: `::/0`
    remote_ipv_6_network_cidr: ?[]const u8 = null,

    /// Indicate whether the VPN connection uses static routes only. If you are
    /// creating a VPN
    /// connection for a device that does not support BGP, you must specify `true`.
    /// Use CreateVpnConnectionRoute to create a static route.
    ///
    /// Default: `false`
    static_routes_only: ?bool = null,

    /// The transit gateway attachment ID to use for the VPN tunnel.
    ///
    /// Required if `OutsideIpAddressType` is set to `PrivateIpv4`.
    transport_transit_gateway_attachment_id: ?[]const u8 = null,

    /// The desired bandwidth specification for the VPN tunnel, used when creating
    /// or modifying VPN connection options to set the tunnel's throughput
    /// capacity. `standard` supports up to 1.25 Gbps per tunnel, while `large`
    /// supports up to 5 Gbps per tunnel. The default value is `standard`. Existing
    /// VPN connections without a bandwidth setting will automatically default to
    /// `standard`.
    tunnel_bandwidth: ?VpnTunnelBandwidth = null,

    /// Indicate whether the VPN tunnels process IPv4 or IPv6 traffic.
    ///
    /// Default: `ipv4`
    tunnel_inside_ip_version: ?TunnelInsideIpVersion = null,

    /// The tunnel options for the VPN connection.
    tunnel_options: ?[]const VpnTunnelOptionsSpecification = null,
};
