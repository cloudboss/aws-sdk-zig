const JobStatus = @import("job_status.zig").JobStatus;

/// Details about an imported annotation item.
pub const AnnotationImportItemDetail = struct {
    /// The item's job status.
    job_status: JobStatus,

    /// The source file's location in Amazon S3.
    source: []const u8,

    pub const json_field_names = .{
        .job_status = "jobStatus",
        .source = "source",
    };
};
