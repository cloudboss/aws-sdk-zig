const SyncJobStatus = @import("sync_job_status.zig").SyncJobStatus;

/// The SyncJob summary.
pub const SyncJobSummary = struct {
    /// The SyncJob summary ARN.
    arn: ?[]const u8 = null,

    /// The creation date and time.
    creation_date_time: ?i64 = null,

    /// The SyncJob summaries status.
    status: ?SyncJobStatus = null,

    /// The sync source.
    sync_source: ?[]const u8 = null,

    /// The update date and time.
    update_date_time: ?i64 = null,

    /// The ID of the workspace that contains the sync job.
    workspace_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_date_time = "creationDateTime",
        .status = "status",
        .sync_source = "syncSource",
        .update_date_time = "updateDateTime",
        .workspace_id = "workspaceId",
    };
};
