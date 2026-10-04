/// The VPC connection properties used when creating a connection.
pub const VpcPropertiesInput = struct {
    /// The security group ID of the VPC connection. Must match the pattern
    /// `^sg-[a-z0-9]+$`. Maximum length of 32.
    security_group_id: ?[]const u8 = null,

    /// The subnet IDs of the VPC connection. You can specify between 1 and 16
    /// subnet IDs.
    subnet_ids: []const []const u8,

    /// The identifier of the VPC. Must match the pattern `^vpc-[a-z0-9]+$`. Maximum
    /// length of 32.
    vpc_id: []const u8,

    pub const json_field_names = .{
        .security_group_id = "securityGroupId",
        .subnet_ids = "subnetIds",
        .vpc_id = "vpcId",
    };
};
