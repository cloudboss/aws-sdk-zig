const EntityStatus = @import("entity_status.zig").EntityStatus;

/// Summary information about a deployment.
pub const DeploymentSummary = struct {
    /// The Amazon Resource Name (ARN) of the deployment.
    deployment_arn: []const u8,

    /// The service-generated id of the deployment.
    deployment_id: []const u8,

    /// The name of the deployment.
    deployment_name: ?[]const u8 = null,

    /// Specifies whether a published version of the resource exists.
    has_published_version: ?bool = null,

    /// The current status of the resource: `DRAFT` (unpublished, editable),
    /// `ACTIVE` (published, in use), or `DISABLED` (deactivated; changes cannot be
    /// published until the resource is re-enabled).
    status: ?EntityStatus = null,

    /// The time when the resource was last updated. For a snapshot, this is the
    /// time when the snapshot was created.
    updated_at: ?i64 = null,

    /// The version of the resource.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .deployment_arn = "deploymentArn",
        .deployment_id = "deploymentId",
        .deployment_name = "deploymentName",
        .has_published_version = "hasPublishedVersion",
        .status = "status",
        .updated_at = "updatedAt",
        .version = "version",
    };
};
