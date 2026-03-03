const AwsRdsDbSubnetGroupSubnet = @import("aws_rds_db_subnet_group_subnet.zig").AwsRdsDbSubnetGroupSubnet;

/// Information about the subnet group for the database instance.
pub const AwsRdsDbSubnetGroup = struct {
    /// The ARN of the subnet group.
    db_subnet_group_arn: ?[]const u8 = null,

    /// The description of the subnet group.
    db_subnet_group_description: ?[]const u8 = null,

    /// The name of the subnet group.
    db_subnet_group_name: ?[]const u8 = null,

    /// The status of the subnet group.
    subnet_group_status: ?[]const u8 = null,

    /// A list of subnets in the subnet group.
    subnets: ?[]const AwsRdsDbSubnetGroupSubnet = null,

    /// The VPC ID of the subnet group.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .db_subnet_group_arn = "DbSubnetGroupArn",
        .db_subnet_group_description = "DbSubnetGroupDescription",
        .db_subnet_group_name = "DbSubnetGroupName",
        .subnet_group_status = "SubnetGroupStatus",
        .subnets = "Subnets",
        .vpc_id = "VpcId",
    };
};
