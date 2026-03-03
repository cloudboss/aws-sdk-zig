/// Information about a bulk deployment. You cannot start a new bulk deployment
/// while another one is still running or in a non-terminal state.
pub const BulkDeployment = struct {
    /// The ARN of the bulk deployment.
    bulk_deployment_arn: ?[]const u8 = null,

    /// The ID of the bulk deployment.
    bulk_deployment_id: ?[]const u8 = null,

    /// The time, in ISO format, when the deployment was created.
    created_at: ?[]const u8 = null,

    pub const json_field_names = .{
        .bulk_deployment_arn = "BulkDeploymentArn",
        .bulk_deployment_id = "BulkDeploymentId",
        .created_at = "CreatedAt",
    };
};
