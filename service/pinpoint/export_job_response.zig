const ExportJobResource = @import("export_job_resource.zig").ExportJobResource;
const JobStatus = @import("job_status.zig").JobStatus;

/// Provides information about the status and settings of a job that exports
/// endpoint definitions to a file. The file can be added directly to an Amazon
/// Simple Storage Service (Amazon S3) bucket by using the Amazon Pinpoint API
/// or downloaded directly to a computer by using the Amazon Pinpoint console.
pub const ExportJobResponse = struct {
    /// The unique identifier for the application that's associated with the export
    /// job.
    application_id: []const u8,

    /// The number of pieces that were processed successfully (completed) by the
    /// export job, as of the time of the request.
    completed_pieces: ?i32 = null,

    /// The date, in ISO 8601 format, when the export job was completed.
    completion_date: ?[]const u8 = null,

    /// The date, in ISO 8601 format, when the export job was created.
    creation_date: []const u8,

    /// The resource settings that apply to the export job.
    definition: ExportJobResource,

    /// The number of pieces that weren't processed successfully (failed) by the
    /// export job, as of the time of the request.
    failed_pieces: ?i32 = null,

    /// An array of entries, one for each of the first 100 entries that weren't
    /// processed successfully (failed) by the export job, if any.
    failures: ?[]const []const u8 = null,

    /// The unique identifier for the export job.
    id: []const u8,

    /// The status of the export job. The job status is FAILED if Amazon Pinpoint
    /// wasn't able to process one or more pieces in the job.
    job_status: JobStatus,

    /// The total number of endpoint definitions that weren't processed successfully
    /// (failed) by the export job, typically because an error, such as a syntax
    /// error, occurred.
    total_failures: ?i32 = null,

    /// The total number of pieces that must be processed to complete the export
    /// job. Each piece consists of an approximately equal portion of the endpoint
    /// definitions that are part of the export job.
    total_pieces: ?i32 = null,

    /// The total number of endpoint definitions that were processed by the export
    /// job.
    total_processed: ?i32 = null,

    /// The job type. This value is EXPORT for export jobs.
    @"type": []const u8,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .completed_pieces = "CompletedPieces",
        .completion_date = "CompletionDate",
        .creation_date = "CreationDate",
        .definition = "Definition",
        .failed_pieces = "FailedPieces",
        .failures = "Failures",
        .id = "Id",
        .job_status = "JobStatus",
        .total_failures = "TotalFailures",
        .total_pieces = "TotalPieces",
        .total_processed = "TotalProcessed",
        .@"type" = "Type",
    };
};
