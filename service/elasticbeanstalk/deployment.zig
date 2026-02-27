/// Information about an application version deployment.
pub const Deployment = struct {
    /// The ID of the deployment. This number increases by one each time that you
    /// deploy source
    /// code or change instance configuration settings.
    deployment_id: ?i64,

    /// For in-progress deployments, the time that the deployment started.
    ///
    /// For completed deployments, the time that the deployment ended.
    deployment_time: ?i64,

    /// The status of the deployment:
    ///
    /// * `In Progress` : The deployment is in progress.
    ///
    /// * `Deployed` : The deployment succeeded.
    ///
    /// * `Failed` : The deployment failed.
    status: ?[]const u8,

    /// The version label of the application version in the deployment.
    version_label: ?[]const u8,
};
