pub const GetDeploymentRequest = struct {
    /// The unique identifier of the application.
    application_id: []const u8,

    /// The unique identifier for the deployment.
    deployment_id: []const u8,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .deployment_id = "deploymentId",
    };
};
