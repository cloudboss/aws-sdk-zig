pub const CreateDeploymentResponse = struct {
    /// The unique identifier of the deployment.
    deployment_id: []const u8,

    pub const json_field_names = .{
        .deployment_id = "deploymentId",
    };
};
