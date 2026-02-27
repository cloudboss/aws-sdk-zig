const JobStatus = @import("job_status.zig").JobStatus;
const OutputDataConfig = @import("output_data_config.zig").OutputDataConfig;

/// The properties of a FHIR export job.
pub const ExportJobProperties = struct {
    /// The Amazon Resource Name (ARN) used during the initiation of the export job.
    data_access_role_arn: ?[]const u8,

    /// The data store identifier from which files are being exported.
    datastore_id: []const u8,

    /// The time the export job completed.
    end_time: ?i64,

    /// The export job identifier.
    job_id: []const u8,

    /// The export job name.
    job_name: ?[]const u8,

    /// The export job status.
    job_status: JobStatus,

    /// An explanation of any errors that might have occurred during the export job.
    message: ?[]const u8,

    /// The output data configuration supplied when the export job was created.
    output_data_config: OutputDataConfig,

    /// The time the export job was initiated.
    submit_time: i64,

    pub const json_field_names = .{
        .data_access_role_arn = "DataAccessRoleArn",
        .datastore_id = "DatastoreId",
        .end_time = "EndTime",
        .job_id = "JobId",
        .job_name = "JobName",
        .job_status = "JobStatus",
        .message = "Message",
        .output_data_config = "OutputDataConfig",
        .submit_time = "SubmitTime",
    };
};
