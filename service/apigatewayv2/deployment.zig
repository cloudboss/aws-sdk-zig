const DeploymentStatus = @import("deployment_status.zig").DeploymentStatus;

/// An immutable representation of an API that can be called by users. A
/// Deployment must be associated with a Stage for it to be callable over the
/// internet.
pub const Deployment = struct {
    /// Specifies whether a deployment was automatically released.
    auto_deployed: ?bool,

    /// The date and time when the Deployment resource was created.
    created_date: ?i64,

    /// The identifier for the deployment.
    deployment_id: ?[]const u8,

    /// The status of the deployment: PENDING, FAILED, or SUCCEEDED.
    deployment_status: ?DeploymentStatus,

    /// May contain additional feedback on the status of an API deployment.
    deployment_status_message: ?[]const u8,

    /// The description for the deployment.
    description: ?[]const u8,

    pub const json_field_names = .{
        .auto_deployed = "AutoDeployed",
        .created_date = "CreatedDate",
        .deployment_id = "DeploymentId",
        .deployment_status = "DeploymentStatus",
        .deployment_status_message = "DeploymentStatusMessage",
        .description = "Description",
    };
};
