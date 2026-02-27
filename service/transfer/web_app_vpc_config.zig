/// Contains the VPC configuration settings for hosting a web app endpoint,
/// including the VPC ID, subnet IDs, and security group IDs for access control.
pub const WebAppVpcConfig = struct {
    /// The list of security group IDs that control access to the web app endpoint.
    /// These security groups determine which sources can access the endpoint based
    /// on IP addresses and port configurations.
    security_group_ids: ?[]const []const u8,

    /// The list of subnet IDs within the VPC where the web app endpoint will be
    /// deployed. These subnets must be in the same VPC specified in the VpcId
    /// parameter.
    subnet_ids: ?[]const []const u8,

    /// The identifier of the VPC where the web app endpoint will be hosted.
    vpc_id: ?[]const u8,

    pub const json_field_names = .{
        .security_group_ids = "SecurityGroupIds",
        .subnet_ids = "SubnetIds",
        .vpc_id = "VpcId",
    };
};
