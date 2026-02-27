const aws = @import("aws");

const WorkspaceStatus = @import("workspace_status.zig").WorkspaceStatus;

/// The full details about one Amazon Managed Service for Prometheus workspace
/// in your account.
pub const WorkspaceDescription = struct {
    /// The alias that is assigned to this workspace to help identify it. It does
    /// not need to be unique.
    alias: ?[]const u8,

    /// The ARN of the workspace. For example,
    /// `arn:aws:aps:<region>:123456789012:workspace/ws-example1-1234-abcd-5678-ef90abcd1234`.
    arn: []const u8,

    /// The date and time that the workspace was created.
    created_at: i64,

    /// (optional) If the workspace was created with a customer managed KMS key, the
    /// ARN for the key used.
    kms_key_arn: ?[]const u8,

    /// The Prometheus endpoint available for this workspace. For example,
    /// `https://aps-workspaces.<region>.amazonaws.com/workspaces/ws-example1-1234-abcd-5678-ef90abcd1234/api/v1/`.
    prometheus_endpoint: ?[]const u8,

    /// The current status of the workspace.
    status: WorkspaceStatus,

    /// The list of tag keys and values that are associated with the workspace.
    tags: ?[]const aws.map.StringMapEntry,

    /// The unique ID for the workspace. For example,
    /// `ws-example1-1234-abcd-5678-ef90abcd1234`.
    workspace_id: []const u8,

    pub const json_field_names = .{
        .alias = "alias",
        .arn = "arn",
        .created_at = "createdAt",
        .kms_key_arn = "kmsKeyArn",
        .prometheus_endpoint = "prometheusEndpoint",
        .status = "status",
        .tags = "tags",
        .workspace_id = "workspaceId",
    };
};
