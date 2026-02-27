const Subnet = @import("subnet.zig").Subnet;

/// Contains the details of an Amazon Neptune DB subnet group.
///
/// This data type is used as a response element in the DescribeDBSubnetGroups
/// action.
pub const DBSubnetGroup = struct {
    /// The Amazon Resource Name (ARN) for the DB subnet group.
    db_subnet_group_arn: ?[]const u8,

    /// Provides the description of the DB subnet group.
    db_subnet_group_description: ?[]const u8,

    /// The name of the DB subnet group.
    db_subnet_group_name: ?[]const u8,

    /// Provides the status of the DB subnet group.
    subnet_group_status: ?[]const u8,

    /// Contains a list of Subnet elements.
    subnets: ?[]const Subnet,

    /// Provides the VpcId of the DB subnet group.
    vpc_id: ?[]const u8,
};
