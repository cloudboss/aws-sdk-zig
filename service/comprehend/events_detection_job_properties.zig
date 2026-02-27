const InputDataConfig = @import("input_data_config.zig").InputDataConfig;
const JobStatus = @import("job_status.zig").JobStatus;
const LanguageCode = @import("language_code.zig").LanguageCode;
const OutputDataConfig = @import("output_data_config.zig").OutputDataConfig;

/// Provides information about an events detection job.
pub const EventsDetectionJobProperties = struct {
    /// The Amazon Resource Name (ARN) of the IAM role that
    /// grants Amazon Comprehend read access to your input data.
    data_access_role_arn: ?[]const u8,

    /// The time that the events detection job completed.
    end_time: ?i64,

    /// The input data configuration that you supplied when you created the events
    /// detection
    /// job.
    input_data_config: ?InputDataConfig,

    /// The Amazon Resource Name (ARN) of the events detection job. It is a unique,
    /// fully
    /// qualified identifier for the job. It includes the Amazon Web Services
    /// account, Amazon Web Services Region, and the job ID. The
    /// format of the ARN is as follows:
    ///
    /// `arn::comprehend:::events-detection-job/`
    ///
    /// The following is an example job ARN:
    ///
    /// `arn:aws:comprehend:us-west-2:111122223333:events-detection-job/1234abcd12ab34cd56ef1234567890ab`
    job_arn: ?[]const u8,

    /// The identifier assigned to the events detection job.
    job_id: ?[]const u8,

    /// The name you assigned the events detection job.
    job_name: ?[]const u8,

    /// The current status of the events detection job.
    job_status: ?JobStatus,

    /// The language code of the input documents.
    language_code: ?LanguageCode,

    /// A description of the status of the events detection job.
    message: ?[]const u8,

    /// The output data configuration that you supplied when you created the events
    /// detection
    /// job.
    output_data_config: ?OutputDataConfig,

    /// The time that the events detection job was submitted for processing.
    submit_time: ?i64,

    /// The types of events that are detected by the job.
    target_event_types: ?[]const []const u8,

    pub const json_field_names = .{
        .data_access_role_arn = "DataAccessRoleArn",
        .end_time = "EndTime",
        .input_data_config = "InputDataConfig",
        .job_arn = "JobArn",
        .job_id = "JobId",
        .job_name = "JobName",
        .job_status = "JobStatus",
        .language_code = "LanguageCode",
        .message = "Message",
        .output_data_config = "OutputDataConfig",
        .submit_time = "SubmitTime",
        .target_event_types = "TargetEventTypes",
    };
};
