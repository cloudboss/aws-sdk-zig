const EC2SecurityGroup = @import("ec2_security_group.zig").EC2SecurityGroup;
const IPRange = @import("ip_range.zig").IPRange;

/// Contains the details for an Amazon RDS DB security group.
///
/// This data type is used as a response element in the
/// `DescribeDBSecurityGroups` action.
pub const DBSecurityGroup = struct {
    /// The Amazon Resource Name (ARN) for the DB security group.
    db_security_group_arn: ?[]const u8 = null,

    /// Provides the description of the DB security group.
    db_security_group_description: ?[]const u8 = null,

    /// Specifies the name of the DB security group.
    db_security_group_name: ?[]const u8 = null,

    /// Contains a list of `EC2SecurityGroup` elements.
    ec2_security_groups: ?[]const EC2SecurityGroup = null,

    /// Contains a list of `IPRange` elements.
    ip_ranges: ?[]const IPRange = null,

    /// Provides the Amazon Web Services ID of the owner of a specific DB security
    /// group.
    owner_id: ?[]const u8 = null,

    /// Provides the VpcId of the DB security group.
    vpc_id: ?[]const u8 = null,
};
