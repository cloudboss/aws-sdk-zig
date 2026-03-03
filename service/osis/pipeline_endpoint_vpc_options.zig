/// Configuration settings for the VPC endpoint, specifying network access
/// controls.
pub const PipelineEndpointVpcOptions = struct {
    /// A list of security group IDs that control network access to the pipeline
    /// endpoint.
    security_group_ids: ?[]const []const u8 = null,

    /// A list of subnet IDs where the pipeline endpoint network interfaces are
    /// created.
    subnet_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .security_group_ids = "SecurityGroupIds",
        .subnet_ids = "SubnetIds",
    };
};
