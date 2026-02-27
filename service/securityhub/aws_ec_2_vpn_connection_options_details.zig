const AwsEc2VpnConnectionOptionsTunnelOptionsDetails = @import("aws_ec_2_vpn_connection_options_tunnel_options_details.zig").AwsEc2VpnConnectionOptionsTunnelOptionsDetails;

/// VPN connection options.
pub const AwsEc2VpnConnectionOptionsDetails = struct {
    /// Whether the VPN connection uses static routes only.
    static_routes_only: ?bool,

    /// The VPN tunnel options.
    tunnel_options: ?[]const AwsEc2VpnConnectionOptionsTunnelOptionsDetails,

    pub const json_field_names = .{
        .static_routes_only = "StaticRoutesOnly",
        .tunnel_options = "TunnelOptions",
    };
};
