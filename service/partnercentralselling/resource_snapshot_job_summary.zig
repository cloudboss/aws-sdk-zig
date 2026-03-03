const ResourceSnapshotJobStatus = @import("resource_snapshot_job_status.zig").ResourceSnapshotJobStatus;

/// An object that contains a `Resource Snapshot Job`'s subset of fields.
pub const ResourceSnapshotJobSummary = struct {
    /// The Amazon Resource Name (ARN) for the resource snapshot job.
    arn: ?[]const u8 = null,

    /// The unique identifier of the Engagement.
    engagement_id: ?[]const u8 = null,

    /// The unique identifier for the resource snapshot job within the AWS Partner
    /// Central system. This ID is used for direct references to the job within the
    /// service.
    id: ?[]const u8 = null,

    /// The current status of the snapshot job.
    ///
    /// Valid values:
    ///
    /// * STOPPED: The job is not currently running.
    /// * RUNNING: The job is actively executing.
    status: ?ResourceSnapshotJobStatus = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .engagement_id = "EngagementId",
        .id = "Id",
        .status = "Status",
    };
};
