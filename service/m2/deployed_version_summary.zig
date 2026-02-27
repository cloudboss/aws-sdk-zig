const DeploymentLifecycle = @import("deployment_lifecycle.zig").DeploymentLifecycle;

/// Contains a summary of a deployed application.
pub const DeployedVersionSummary = struct {
    /// The version of the deployed application.
    application_version: i32,

    /// The status of the deployment.
    status: DeploymentLifecycle,

    /// The reason for the reported status.
    status_reason: ?[]const u8,

    pub const json_field_names = .{
        .application_version = "applicationVersion",
        .status = "status",
        .status_reason = "statusReason",
    };
};
