const JobStatus = @import("job_status.zig").JobStatus;

/// Details about an imported variant item.
pub const VariantImportItemDetail = struct {
    /// The item's job status.
    job_status: JobStatus,

    /// The source file's location in Amazon S3.
    source: []const u8,

    /// A message that provides additional context about a job
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .job_status = "jobStatus",
        .source = "source",
        .status_message = "statusMessage",
    };
};
