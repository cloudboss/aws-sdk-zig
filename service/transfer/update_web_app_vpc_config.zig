/// Contains the VPC configuration settings for updating a web app endpoint,
/// including the subnet IDs where the endpoint should be deployed.
pub const UpdateWebAppVpcConfig = struct {
    /// The list of subnet IDs within the VPC where the web app endpoint should be
    /// deployed during the update operation.
    subnet_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .subnet_ids = "SubnetIds",
    };
};
