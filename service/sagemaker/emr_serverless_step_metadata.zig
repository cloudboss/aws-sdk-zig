/// The configurations and outcomes of an Amazon EMR Serverless step execution.
pub const EMRServerlessStepMetadata = struct {
    /// The identifier of the Amazon EMR Serverless application.
    application_id: ?[]const u8 = null,

    /// The identifier of the Amazon EMR Serverless job run.
    job_run_id: ?[]const u8 = null,

    /// The name of the Amazon EMR Serverless job run.
    job_run_name: ?[]const u8 = null,

    /// The path to the log file for the Amazon EMR Serverless job run.
    log_file_path: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .job_run_id = "JobRunId",
        .job_run_name = "JobRunName",
        .log_file_path = "LogFilePath",
    };
};
