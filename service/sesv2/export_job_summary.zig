const ExportSourceType = @import("export_source_type.zig").ExportSourceType;
const JobStatus = @import("job_status.zig").JobStatus;

/// A summary of the export job.
pub const ExportJobSummary = struct {
    /// The timestamp of when the export job was completed.
    completed_timestamp: ?i64,

    /// The timestamp of when the export job was created.
    created_timestamp: ?i64,

    /// The source type of the export job.
    export_source_type: ?ExportSourceType,

    /// The export job ID.
    job_id: ?[]const u8,

    /// The status of the export job.
    job_status: ?JobStatus,

    pub const json_field_names = .{
        .completed_timestamp = "CompletedTimestamp",
        .created_timestamp = "CreatedTimestamp",
        .export_source_type = "ExportSourceType",
        .job_id = "JobId",
        .job_status = "JobStatus",
    };
};
