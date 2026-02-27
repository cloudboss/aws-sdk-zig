const EdgeDeploymentConfig = @import("edge_deployment_config.zig").EdgeDeploymentConfig;
const EdgeDeploymentStatus = @import("edge_deployment_status.zig").EdgeDeploymentStatus;
const DeviceSelectionConfig = @import("device_selection_config.zig").DeviceSelectionConfig;

/// Contains information summarizing the deployment stage results.
pub const DeploymentStageStatusSummary = struct {
    /// Configuration of the deployment details.
    deployment_config: EdgeDeploymentConfig,

    /// General status of the current state.
    deployment_status: EdgeDeploymentStatus,

    /// Configuration of the devices in the stage.
    device_selection_config: DeviceSelectionConfig,

    /// The name of the stage.
    stage_name: []const u8,

    pub const json_field_names = .{
        .deployment_config = "DeploymentConfig",
        .deployment_status = "DeploymentStatus",
        .device_selection_config = "DeviceSelectionConfig",
        .stage_name = "StageName",
    };
};
