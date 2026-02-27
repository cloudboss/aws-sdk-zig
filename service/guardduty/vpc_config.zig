const SecurityGroup = @import("security_group.zig").SecurityGroup;

/// Amazon Virtual Private Cloud configuration details associated with your
/// Lambda function.
pub const VpcConfig = struct {
    /// The identifier of the security group attached to the Lambda function.
    security_groups: ?[]const SecurityGroup,

    /// The identifiers of the subnets that are associated with your Lambda
    /// function.
    subnet_ids: ?[]const []const u8,

    /// The identifier of the Amazon Virtual Private Cloud.
    vpc_id: ?[]const u8,

    pub const json_field_names = .{
        .security_groups = "SecurityGroups",
        .subnet_ids = "SubnetIds",
        .vpc_id = "VpcId",
    };
};
