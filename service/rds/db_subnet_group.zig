const Subnet = @import("subnet.zig").Subnet;

/// Contains the details of an Amazon RDS DB subnet group.
///
/// This data type is used as a response element in the `DescribeDBSubnetGroups`
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

    /// Contains a list of `Subnet` elements. The list of subnets shown here might
    /// not reflect the current state of your VPC. For the most up-to-date
    /// information, we recommend checking your VPC configuration directly.
    subnets: ?[]const Subnet = null,

    /// The network type of the DB subnet group.
    ///
    /// Valid values:
    ///
    /// * `IPV4`
    /// * `DUAL`
    ///
    /// A `DBSubnetGroup` can support only the IPv4 protocol or the IPv4 and the
    /// IPv6 protocols (`DUAL`).
    ///
    /// For more information, see [ Working with a DB instance in a
    /// VPC](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_VPC.WorkingWithRDSInstanceinaVPC.html) in the *Amazon RDS User Guide.*
    supported_network_types: ?[]const []const u8 = null,

    /// Provides the VpcId of the DB subnet group.
    vpc_id: ?[]const u8 = null,
};
