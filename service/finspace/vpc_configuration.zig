const IPAddressType = @import("ip_address_type.zig").IPAddressType;

/// Configuration details about the network where the Privatelink endpoint of
/// the cluster resides.
pub const VpcConfiguration = struct {
    /// The IP address type for cluster network configuration parameters. The
    /// following type is available:
    ///
    /// * IP_V4 – IP address version 4
    ip_address_type: ?IPAddressType,

    /// The unique identifier of the VPC security group applied to the VPC endpoint
    /// ENI for the cluster.
    security_group_ids: ?[]const []const u8,

    /// The identifier of the subnet that the Privatelink VPC endpoint uses to
    /// connect to the cluster.
    subnet_ids: ?[]const []const u8,

    /// The identifier of the VPC endpoint.
    vpc_id: ?[]const u8,

    pub const json_field_names = .{
        .ip_address_type = "ipAddressType",
        .security_group_ids = "securityGroupIds",
        .subnet_ids = "subnetIds",
        .vpc_id = "vpcId",
    };
};
