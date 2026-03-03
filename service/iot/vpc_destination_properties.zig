/// The properties of a virtual private cloud (VPC) destination.
pub const VpcDestinationProperties = struct {
    /// The ARN of a role that has permission to create and attach to elastic
    /// network interfaces (ENIs).
    role_arn: ?[]const u8 = null,

    /// The security groups of the VPC destination.
    security_groups: ?[]const []const u8 = null,

    /// The subnet IDs of the VPC destination.
    subnet_ids: ?[]const []const u8 = null,

    /// The ID of the VPC.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .role_arn = "roleArn",
        .security_groups = "securityGroups",
        .subnet_ids = "subnetIds",
        .vpc_id = "vpcId",
    };
};
