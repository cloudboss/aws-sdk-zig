const DeploymentStatus = @import("deployment_status.zig").DeploymentStatus;

/// For a multi-location container fleet, describes the progress of a deployment
/// across
/// all fleet locations.
pub const LocationalDeployment = struct {
    /// The status of fleet deployment activity in the location.
    ///
    /// * `IN_PROGRESS` -- The deployment is in progress.
    ///
    /// * `IMPAIRED` -- The deployment failed and the fleet has some impaired
    /// containers.
    ///
    /// * `COMPLETE` -- The deployment has completed successfully.
    ///
    /// * `ROLLBACK_IN_PROGRESS` -- The deployment failed and rollback has
    /// been initiated.
    ///
    /// * `ROLLBACK_IN_COMPLETE` -- The deployment failed and rollback has
    /// been completed.
    ///
    /// * `CANCELLED` -- The deployment was cancelled.
    deployment_status: ?DeploymentStatus = null,

    pub const json_field_names = .{
        .deployment_status = "DeploymentStatus",
    };
};
