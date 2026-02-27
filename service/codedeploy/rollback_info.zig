/// Information about a deployment rollback.
pub const RollbackInfo = struct {
    /// The ID of the deployment rollback.
    rollback_deployment_id: ?[]const u8,

    /// Information that describes the status of a deployment rollback (for example,
    /// whether
    /// the deployment can't be rolled back, is in progress, failed, or succeeded).
    rollback_message: ?[]const u8,

    /// The deployment ID of the deployment that was underway and triggered a
    /// rollback
    /// deployment because it failed or was stopped.
    rollback_triggering_deployment_id: ?[]const u8,

    pub const json_field_names = .{
        .rollback_deployment_id = "rollbackDeploymentId",
        .rollback_message = "rollbackMessage",
        .rollback_triggering_deployment_id = "rollbackTriggeringDeploymentId",
    };
};
