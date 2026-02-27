const EdgeDeploymentConfig = @import("edge_deployment_config.zig").EdgeDeploymentConfig;
const DeviceSelectionConfig = @import("device_selection_config.zig").DeviceSelectionConfig;

/// Contains information about a stage in an edge deployment plan.
pub const DeploymentStage = struct {
    /// Configuration of the deployment details.
    deployment_config: ?EdgeDeploymentConfig,

    /// Configuration of the devices in the stage.
    device_selection_config: DeviceSelectionConfig,

    /// The name of the stage.
    stage_name: []const u8,

    pub const json_field_names = .{
        .deployment_config = "DeploymentConfig",
        .device_selection_config = "DeviceSelectionConfig",
        .stage_name = "StageName",
    };
};
