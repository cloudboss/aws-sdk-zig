const TransformationJobStatus = @import("transformation_job_status.zig").TransformationJobStatus;
const SourceFormat = @import("source_format.zig").SourceFormat;

/// Contains summary information about a data transformation job. To retrieve
/// full job details, call `DescribeDataTransformationJob`.
pub const TransformationJobSummary = struct {
    /// The timestamp when the job completed.
    end_time: ?i64 = null,

    /// The unique identifier of the job.
    job_id: []const u8,

    /// The name of the job.
    job_name: ?[]const u8 = null,

    /// The current status of the job.
    job_status: TransformationJobStatus,

    /// The source data format for this job.
    source_format: ?SourceFormat = null,

    /// The timestamp when the job was submitted.
    submit_time: i64,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .job_id = "JobId",
        .job_name = "JobName",
        .job_status = "JobStatus",
        .source_format = "SourceFormat",
        .submit_time = "SubmitTime",
    };
};
