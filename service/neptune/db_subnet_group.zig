const Subnet = @import("subnet.zig").Subnet;

/// Contains the details of an Amazon Neptune DB subnet group.
///
/// This data type is used as a response element in the DescribeDBSubnetGroups
/// action.
pub const DBSubnetGroup = struct {
    /// The Amazon Resource Name (ARN) for the DB subnet group.
    db_subnet_group_arn: ?[]const u8 = null,

    /// Provides the description of the DB subnet group.
    db_subnet_group_description: ?[]const u8 = null,

    /// The name of the DB subnet group.
    db_subnet_group_name: ?[]const u8 = null,

    /// Provides the status of the DB subnet group.
    subnet_group_status: ?[]const u8 = null,

    /// Contains a list of Subnet elements.
    subnets: ?[]const Subnet = null,

    /// The network types supported by the DB subnet group.
    ///
    /// Valid network types include `IPV4` and `DUAL`. A DB subnet group
    /// supports `DUAL` if all subnets in the group have both IPv4 and IPv6 CIDRs.
    supported_network_types: ?[]const []const u8 = null,

    /// Provides the VpcId of the DB subnet group.
    vpc_id: ?[]const u8 = null,
};
