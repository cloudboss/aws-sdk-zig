const Subnet = @import("subnet.zig").Subnet;

/// Detailed information about a subnet group.
pub const DBSubnetGroup = struct {
    /// The Amazon Resource Name (ARN) for the DB subnet group.
    db_subnet_group_arn: ?[]const u8 = null,

    /// Provides the description of the subnet group.
    db_subnet_group_description: ?[]const u8 = null,

    /// The name of the subnet group.
    db_subnet_group_name: ?[]const u8 = null,

    /// Provides the status of the subnet group.
    subnet_group_status: ?[]const u8 = null,

    /// Detailed information about one or more subnets within a subnet group.
    subnets: ?[]const Subnet = null,

    /// The network type of the DB subnet group.
    ///
    /// Valid Values: `IPV4` | `DUAL`
    ///
    /// A `DBSubnetGroup` can support only the IPv4 protocol or the IPv4 and the
    /// IPv6 protocols (DUAL).
    supported_network_types: ?[]const []const u8 = null,

    /// Provides the virtual private cloud (VPC) ID of the subnet group.
    vpc_id: ?[]const u8 = null,
};
