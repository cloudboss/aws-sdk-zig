const EdgePresetDeploymentStatus = @import("edge_preset_deployment_status.zig").EdgePresetDeploymentStatus;
const EdgePresetDeploymentType = @import("edge_preset_deployment_type.zig").EdgePresetDeploymentType;

/// The output of a SageMaker Edge Manager deployable resource.
pub const EdgePresetDeploymentOutput = struct {
    /// The Amazon Resource Name (ARN) of the generated deployable resource.
    artifact: ?[]const u8,

    /// The status of the deployable resource.
    status: ?EdgePresetDeploymentStatus,

    /// Returns a message describing the status of the deployed resource.
    status_message: ?[]const u8,

    /// The deployment type created by SageMaker Edge Manager. Currently only
    /// supports Amazon Web Services IoT Greengrass Version 2 components.
    @"type": EdgePresetDeploymentType,

    pub const json_field_names = .{
        .artifact = "Artifact",
        .status = "Status",
        .status_message = "StatusMessage",
        .@"type" = "Type",
    };
};
