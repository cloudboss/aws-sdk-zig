const DeploymentStatus = @import("deployment_status.zig").DeploymentStatus;

/// Information about the most recent attempted or successful deployment to a
/// deployment
/// group.
pub const LastDeploymentInfo = struct {
    /// A timestamp that indicates when the most recent deployment to the deployment
    /// group
    /// started.
    create_time: ?i64,

    /// The unique ID of a deployment.
    deployment_id: ?[]const u8,

    /// A timestamp that indicates when the most recent deployment to the deployment
    /// group was
    /// complete.
    end_time: ?i64,

    /// The status of the most recent deployment.
    status: ?DeploymentStatus,

    pub const json_field_names = .{
        .create_time = "createTime",
        .deployment_id = "deploymentId",
        .end_time = "endTime",
        .status = "status",
    };
};
