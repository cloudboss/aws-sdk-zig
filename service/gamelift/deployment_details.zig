/// Information about the most recent deployment for the container fleet.
pub const DeploymentDetails = struct {
    /// A unique identifier for a fleet deployment.
    latest_deployment_id: ?[]const u8,

    pub const json_field_names = .{
        .latest_deployment_id = "LatestDeploymentId",
    };
};
