const ExportSourceType = @import("export_source_type.zig").ExportSourceType;
const JobStatus = @import("job_status.zig").JobStatus;

/// A summary of the export job.
pub const ExportJobSummary = struct {
    /// The timestamp of when the export job was completed.
    completed_timestamp: ?i64 = null,

    /// The timestamp of when the export job was created.
    created_timestamp: ?i64 = null,

    /// The source type of the export job.
    export_source_type: ?ExportSourceType = null,

    /// The export job ID.
    job_id: ?[]const u8 = null,

    /// The status of the export job.
    job_status: ?JobStatus = null,

    pub const json_field_names = .{
        .completed_timestamp = "CompletedTimestamp",
        .created_timestamp = "CreatedTimestamp",
        .export_source_type = "ExportSourceType",
        .job_id = "JobId",
        .job_status = "JobStatus",
    };
};
