const IpAddressType = @import("ip_address_type.zig").IpAddressType;

/// Information about your VPC and security groups used with the connector.
pub const VpcInformation = struct {
    /// The VPC IP address type.
    ip_address_type: ?IpAddressType,

    /// The security groups used with the connector. You can use a maximum of 4
    /// security groups
    /// with a connector.
    security_group_ids: []const []const u8,

    pub const json_field_names = .{
        .ip_address_type = "IpAddressType",
        .security_group_ids = "SecurityGroupIds",
    };
};
