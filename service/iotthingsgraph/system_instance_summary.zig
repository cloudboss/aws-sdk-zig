const SystemInstanceDeploymentStatus = @import("system_instance_deployment_status.zig").SystemInstanceDeploymentStatus;
const DeploymentTarget = @import("deployment_target.zig").DeploymentTarget;

/// An object that contains summary information about a system instance.
pub const SystemInstanceSummary = struct {
    /// The ARN of the system instance.
    arn: ?[]const u8 = null,

    /// The date when the system instance was created.
    created_at: ?i64 = null,

    /// The ID of the Greengrass group where the system instance is deployed.
    greengrass_group_id: ?[]const u8 = null,

    /// The ID of the Greengrass group where the system instance is deployed.
    greengrass_group_name: ?[]const u8 = null,

    /// The version of the Greengrass group where the system instance is deployed.
    greengrass_group_version_id: ?[]const u8 = null,

    /// The ID of the system instance.
    id: ?[]const u8 = null,

    /// The status of the system instance.
    status: ?SystemInstanceDeploymentStatus = null,

    /// The target of the system instance.
    target: ?DeploymentTarget = null,

    /// The date and time when the system instance was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .greengrass_group_id = "greengrassGroupId",
        .greengrass_group_name = "greengrassGroupName",
        .greengrass_group_version_id = "greengrassGroupVersionId",
        .id = "id",
        .status = "status",
        .target = "target",
        .updated_at = "updatedAt",
    };
};
