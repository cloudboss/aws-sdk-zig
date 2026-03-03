const InputDataConfig = @import("input_data_config.zig").InputDataConfig;
const OutputDataConfig = @import("output_data_config.zig").OutputDataConfig;
const JobProgressReport = @import("job_progress_report.zig").JobProgressReport;
const JobStatus = @import("job_status.zig").JobStatus;
const ValidationLevel = @import("validation_level.zig").ValidationLevel;

/// The import job properties.
pub const ImportJobProperties = struct {
    /// The Amazon Resource Name (ARN) that grants AWS HealthLake access to the
    /// input data.
    data_access_role_arn: ?[]const u8 = null,

    /// The data store identifier.
    datastore_id: []const u8,

    /// The time the import job was completed.
    end_time: ?i64 = null,

    /// The input data configuration supplied when the import job was created.
    input_data_config: InputDataConfig,

    /// The import job identifier.
    job_id: []const u8,

    /// The import job name.
    job_name: ?[]const u8 = null,

    job_output_data_config: ?OutputDataConfig = null,

    /// Displays the progress of the import job, including total resources scanned,
    /// total
    /// resources imported, and total size of data imported.
    job_progress_report: ?JobProgressReport = null,

    /// The import job status.
    job_status: JobStatus,

    /// An explanation of any errors that might have occurred during the FHIR import
    /// job.
    message: ?[]const u8 = null,

    /// The time the import job was submitted for processing.
    submit_time: i64,

    /// The validation level of the import job.
    validation_level: ?ValidationLevel = null,

    pub const json_field_names = .{
        .data_access_role_arn = "DataAccessRoleArn",
        .datastore_id = "DatastoreId",
        .end_time = "EndTime",
        .input_data_config = "InputDataConfig",
        .job_id = "JobId",
        .job_name = "JobName",
        .job_output_data_config = "JobOutputDataConfig",
        .job_progress_report = "JobProgressReport",
        .job_status = "JobStatus",
        .message = "Message",
        .submit_time = "SubmitTime",
        .validation_level = "ValidationLevel",
    };
};
