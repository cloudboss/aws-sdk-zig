const TransformationInputDataConfig = @import("transformation_input_data_config.zig").TransformationInputDataConfig;
const TransformationJobProgressReport = @import("transformation_job_progress_report.zig").TransformationJobProgressReport;
const TransformationJobStatus = @import("transformation_job_status.zig").TransformationJobStatus;
const TransformationOutputDataConfig = @import("transformation_output_data_config.zig").TransformationOutputDataConfig;

/// Contains the properties of a data transformation job, including its status,
/// configuration, and progress information. You retrieve this structure by
/// calling `DescribeDataTransformationJob`.
pub const TransformationJobProperties = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Web Services Identity and
    /// Access Management (IAM) role that grants HealthLake access to the specified
    /// Amazon S3 locations. HealthLake assumes this role to read input files and
    /// write output files.
    data_access_role_arn: []const u8,

    /// Specifies whether drift detection is enabled for this job. When enabled,
    /// HealthLake writes a drift report to the output Amazon S3 location alongside
    /// the converted files.
    drift_detection_enabled: ?bool = null,

    /// The timestamp when the job completed or failed.
    end_time: ?i64 = null,

    /// The Amazon S3 location and format of the source files for this job.
    input_data_config: TransformationInputDataConfig,

    /// The unique identifier of the data transformation job.
    job_id: []const u8,

    /// The name of the data transformation job.
    job_name: ?[]const u8 = null,

    /// The progress report for the data transformation job, including counts of
    /// files processed and resources generated.
    job_progress_report: ?TransformationJobProgressReport = null,

    /// The current status of the data transformation job.
    job_status: TransformationJobStatus,

    /// An informational message about the job, such as an error description if the
    /// job failed.
    message: ?[]const u8 = null,

    /// The Amazon S3 location and encryption configuration for the converted
    /// output.
    output_data_config: TransformationOutputDataConfig,

    /// The unique identifier of the data transformation profile used for this job.
    profile_id: ?[]const u8 = null,

    /// The name of the data transformation profile used for this job.
    profile_name: ?[]const u8 = null,

    /// The version number of the data transformation profile used for this job.
    profile_version: ?i32 = null,

    /// Specifies whether FHIR R4 Provenance resource generation is enabled for this
    /// transformation job. When provenance is enabled, the service also generates
    /// related DocumentReference and Device resources.
    provenance_enabled: ?bool = null,

    /// The timestamp when the job was submitted.
    submit_time: i64,

    pub const json_field_names = .{
        .data_access_role_arn = "DataAccessRoleArn",
        .drift_detection_enabled = "DriftDetectionEnabled",
        .end_time = "EndTime",
        .input_data_config = "InputDataConfig",
        .job_id = "JobId",
        .job_name = "JobName",
        .job_progress_report = "JobProgressReport",
        .job_status = "JobStatus",
        .message = "Message",
        .output_data_config = "OutputDataConfig",
        .profile_id = "ProfileId",
        .profile_name = "ProfileName",
        .profile_version = "ProfileVersion",
        .provenance_enabled = "ProvenanceEnabled",
        .submit_time = "SubmitTime",
    };
};
