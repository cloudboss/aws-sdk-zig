const aws = @import("aws");

const WorkspaceStatus = @import("workspace_status.zig").WorkspaceStatus;

/// The information about one Amazon Managed Service for Prometheus workspace in
/// your account.
pub const WorkspaceSummary = struct {
    /// The alias that is assigned to this workspace to help identify it. It does
    /// not need to be unique.
    alias: ?[]const u8 = null,

    /// The ARN of the workspace.
    arn: []const u8,

    /// The date and time that the workspace was created.
    created_at: i64,

    /// (optional) If the workspace was created with a customer managed KMS key, the
    /// ARN for the key used.
    kms_key_arn: ?[]const u8 = null,

    /// The current status of the workspace.
    status: WorkspaceStatus,

    /// The list of tag keys and values that are associated with the workspace.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The unique ID for the workspace.
    workspace_id: []const u8,

    pub const json_field_names = .{
        .alias = "alias",
        .arn = "arn",
        .created_at = "createdAt",
        .kms_key_arn = "kmsKeyArn",
        .status = "status",
        .tags = "tags",
        .workspace_id = "workspaceId",
    };
};
