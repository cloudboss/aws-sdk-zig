const ExportJobStatus = @import("export_job_status.zig").ExportJobStatus;

/// This is the summary of an export job.
pub const ExportJobSummary = struct {
    /// This is a timestamp of the time the export job compeleted.
    completion_time: ?i64 = null,

    /// This is a timestamp of the time the export job was created.
    creation_time: ?i64 = null,

    /// This is the unique ARN (Amazon Resource Name) that belongs to the new export
    /// job.
    export_job_arn: ?[]const u8 = null,

    /// This is the unique string that identifies a specific export job.
    export_job_identifier: []const u8,

    /// The unique string that identifies the Amazon Resource Name (ARN) of the
    /// specified search job.
    search_job_arn: ?[]const u8 = null,

    /// The status of the export job is one of the following:
    ///
    /// `CREATED`; `RUNNING`; `FAILED`; or `COMPLETED`.
    status: ?ExportJobStatus = null,

    /// A status message is a string that is returned for an export job.
    ///
    /// A status message is included for any status other than `COMPLETED` without
    /// issues.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .completion_time = "CompletionTime",
        .creation_time = "CreationTime",
        .export_job_arn = "ExportJobArn",
        .export_job_identifier = "ExportJobIdentifier",
        .search_job_arn = "SearchJobArn",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};
