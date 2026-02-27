const ImportJobResource = @import("import_job_resource.zig").ImportJobResource;
const JobStatus = @import("job_status.zig").JobStatus;

/// Provides information about the status and settings of a job that imports
/// endpoint definitions from one or more files. The files can be stored in an
/// Amazon Simple Storage Service (Amazon S3) bucket or uploaded directly from a
/// computer by using the Amazon Pinpoint console.
pub const ImportJobResponse = struct {
    /// The unique identifier for the application that's associated with the import
    /// job.
    application_id: []const u8,

    /// The number of pieces that were processed successfully (completed) by the
    /// import job, as of the time of the request.
    completed_pieces: ?i32,

    /// The date, in ISO 8601 format, when the import job was completed.
    completion_date: ?[]const u8,

    /// The date, in ISO 8601 format, when the import job was created.
    creation_date: []const u8,

    /// The resource settings that apply to the import job.
    definition: ImportJobResource,

    /// The number of pieces that weren't processed successfully (failed) by the
    /// import job, as of the time of the request.
    failed_pieces: ?i32,

    /// An array of entries, one for each of the first 100 entries that weren't
    /// processed successfully (failed) by the import job, if any.
    failures: ?[]const []const u8,

    /// The unique identifier for the import job.
    id: []const u8,

    /// The status of the import job. The job status is FAILED if Amazon Pinpoint
    /// wasn't able to process one or more pieces in the job.
    job_status: JobStatus,

    /// The total number of endpoint definitions that weren't processed successfully
    /// (failed) by the import job, typically because an error, such as a syntax
    /// error, occurred.
    total_failures: ?i32,

    /// The total number of pieces that must be processed to complete the import
    /// job. Each piece consists of an approximately equal portion of the endpoint
    /// definitions that are part of the import job.
    total_pieces: ?i32,

    /// The total number of endpoint definitions that were processed by the import
    /// job.
    total_processed: ?i32,

    /// The job type. This value is IMPORT for import jobs.
    type: []const u8,

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
        .type = "Type",
    };
};
