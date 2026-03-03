const AwsRdsDbSecurityGroupEc2SecurityGroup = @import("aws_rds_db_security_group_ec_2_security_group.zig").AwsRdsDbSecurityGroupEc2SecurityGroup;
const AwsRdsDbSecurityGroupIpRange = @import("aws_rds_db_security_group_ip_range.zig").AwsRdsDbSecurityGroupIpRange;

/// Provides information about an Amazon RDS DB security group.
pub const AwsRdsDbSecurityGroupDetails = struct {
    /// The ARN for the DB security group.
    db_security_group_arn: ?[]const u8 = null,

    /// Provides the description of the DB security group.
    db_security_group_description: ?[]const u8 = null,

    /// Specifies the name of the DB security group.
    db_security_group_name: ?[]const u8 = null,

    /// Contains a list of EC2 security groups.
    ec_2_security_groups: ?[]const AwsRdsDbSecurityGroupEc2SecurityGroup = null,

    /// Contains a list of IP ranges.
    ip_ranges: ?[]const AwsRdsDbSecurityGroupIpRange = null,

    /// Provides the Amazon Web Services ID of the owner of a specific DB security
    /// group.
    owner_id: ?[]const u8 = null,

    /// Provides VPC ID associated with the DB security group.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .db_security_group_arn = "DbSecurityGroupArn",
        .db_security_group_description = "DbSecurityGroupDescription",
        .db_security_group_name = "DbSecurityGroupName",
        .ec_2_security_groups = "Ec2SecurityGroups",
        .ip_ranges = "IpRanges",
        .owner_id = "OwnerId",
        .vpc_id = "VpcId",
    };
};
