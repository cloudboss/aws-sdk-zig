/// Information about deployments related to the specified deployment.
pub const RelatedDeployments = struct {
    /// The deployment IDs of 'auto-update outdated instances' deployments triggered
    /// by this
    /// deployment.
    auto_update_outdated_instances_deployment_ids: ?[]const []const u8 = null,

    /// The deployment ID of the root deployment that triggered this deployment.
    auto_update_outdated_instances_root_deployment_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .auto_update_outdated_instances_deployment_ids = "autoUpdateOutdatedInstancesDeploymentIds",
        .auto_update_outdated_instances_root_deployment_id = "autoUpdateOutdatedInstancesRootDeploymentId",
    };
};
