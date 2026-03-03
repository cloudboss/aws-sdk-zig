const DeploymentLifecycle = @import("deployment_lifecycle.zig").DeploymentLifecycle;

/// A subset of information about a specific deployment.
pub const DeploymentSummary = struct {
    /// The unique identifier of the application.
    application_id: []const u8,

    /// The version of the application.
    application_version: i32,

    /// The timestamp when the deployment was created.
    creation_time: i64,

    /// The unique identifier of the deployment.
    deployment_id: []const u8,

    /// The unique identifier of the runtime environment.
    environment_id: []const u8,

    /// The current status of the deployment.
    status: DeploymentLifecycle,

    /// The reason for the reported status.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .application_version = "applicationVersion",
        .creation_time = "creationTime",
        .deployment_id = "deploymentId",
        .environment_id = "environmentId",
        .status = "status",
        .status_reason = "statusReason",
    };
};
