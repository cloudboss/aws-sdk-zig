const IpType = @import("ip_type.zig").IpType;

/// Specifies the network configuration for the public ingress point.
pub const PublicNetworkConfiguration = struct {
    /// The IP address type for the public ingress point. Valid values are IPV4 and
    /// DUAL_STACK.
    ip_type: IpType = .ipv4,

    pub const json_field_names = .{
        .ip_type = "IpType",
    };
};
