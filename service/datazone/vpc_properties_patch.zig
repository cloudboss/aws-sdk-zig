/// The VPC connection properties used when updating a connection.
pub const VpcPropertiesPatch = struct {
    /// The security group ID of the VPC connection.
    security_group_id: ?[]const u8 = null,

    /// The subnet IDs of the VPC connection.
    subnet_ids: ?[]const []const u8 = null,

    /// The identifier of the VPC.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .security_group_id = "securityGroupId",
        .subnet_ids = "subnetIds",
        .vpc_id = "vpcId",
    };
};
