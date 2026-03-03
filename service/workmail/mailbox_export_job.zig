const MailboxExportJobState = @import("mailbox_export_job_state.zig").MailboxExportJobState;

/// The details of a mailbox export job, including the user or resource ID
/// associated
/// with the mailbox and the S3 bucket that the mailbox contents are exported
/// to.
pub const MailboxExportJob = struct {
    /// The mailbox export job description.
    description: ?[]const u8 = null,

    /// The mailbox export job end timestamp.
    end_time: ?i64 = null,

    /// The identifier of the user or resource associated with the mailbox.
    entity_id: ?[]const u8 = null,

    /// The estimated progress of the mailbox export job, in percentage points.
    estimated_progress: i32 = 0,

    /// The identifier of the mailbox export job.
    job_id: ?[]const u8 = null,

    /// The name of the S3 bucket.
    s3_bucket_name: ?[]const u8 = null,

    /// The path to the S3 bucket and file that the mailbox export job exports to.
    s3_path: ?[]const u8 = null,

    /// The mailbox export job start timestamp.
    start_time: ?i64 = null,

    /// The state of the mailbox export job.
    state: ?MailboxExportJobState = null,

    pub const json_field_names = .{
        .description = "Description",
        .end_time = "EndTime",
        .entity_id = "EntityId",
        .estimated_progress = "EstimatedProgress",
        .job_id = "JobId",
        .s3_bucket_name = "S3BucketName",
        .s3_path = "S3Path",
        .start_time = "StartTime",
        .state = "State",
    };
};
