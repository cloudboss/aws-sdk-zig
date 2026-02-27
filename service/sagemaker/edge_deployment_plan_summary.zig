/// Contains information summarizing an edge deployment plan.
pub const EdgeDeploymentPlanSummary = struct {
    /// The time when the edge deployment plan was created.
    creation_time: ?i64,

    /// The name of the device fleet used for the deployment.
    device_fleet_name: []const u8,

    /// The number of edge devices that failed the deployment.
    edge_deployment_failed: i32,

    /// The number of edge devices yet to pick up the deployment, or in progress.
    edge_deployment_pending: i32,

    /// The ARN of the edge deployment plan.
    edge_deployment_plan_arn: []const u8,

    /// The name of the edge deployment plan.
    edge_deployment_plan_name: []const u8,

    /// The number of edge devices with the successful deployment.
    edge_deployment_success: i32,

    /// The time when the edge deployment plan was last updated.
    last_modified_time: ?i64,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .device_fleet_name = "DeviceFleetName",
        .edge_deployment_failed = "EdgeDeploymentFailed",
        .edge_deployment_pending = "EdgeDeploymentPending",
        .edge_deployment_plan_arn = "EdgeDeploymentPlanArn",
        .edge_deployment_plan_name = "EdgeDeploymentPlanName",
        .edge_deployment_success = "EdgeDeploymentSuccess",
        .last_modified_time = "LastModifiedTime",
    };
};
