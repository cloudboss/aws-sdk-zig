const DeviceDeploymentStatus = @import("device_deployment_status.zig").DeviceDeploymentStatus;

/// Contains information summarizing device details and deployment status.
pub const DeviceDeploymentSummary = struct {
    /// The name of the deployed stage.
    deployed_stage_name: ?[]const u8 = null,

    /// The time when the deployment on the device started.
    deployment_start_time: ?i64 = null,

    /// The description of the device.
    description: ?[]const u8 = null,

    /// The ARN of the device.
    device_arn: []const u8,

    /// The deployment status of the device.
    device_deployment_status: ?DeviceDeploymentStatus = null,

    /// The detailed error message for the deployoment status result.
    device_deployment_status_message: ?[]const u8 = null,

    /// The name of the fleet to which the device belongs to.
    device_fleet_name: ?[]const u8 = null,

    /// The name of the device.
    device_name: []const u8,

    /// The ARN of the edge deployment plan.
    edge_deployment_plan_arn: []const u8,

    /// The name of the edge deployment plan.
    edge_deployment_plan_name: []const u8,

    /// The name of the stage in the edge deployment plan.
    stage_name: []const u8,

    pub const json_field_names = .{
        .deployed_stage_name = "DeployedStageName",
        .deployment_start_time = "DeploymentStartTime",
        .description = "Description",
        .device_arn = "DeviceArn",
        .device_deployment_status = "DeviceDeploymentStatus",
        .device_deployment_status_message = "DeviceDeploymentStatusMessage",
        .device_fleet_name = "DeviceFleetName",
        .device_name = "DeviceName",
        .edge_deployment_plan_arn = "EdgeDeploymentPlanArn",
        .edge_deployment_plan_name = "EdgeDeploymentPlanName",
        .stage_name = "StageName",
    };
};
