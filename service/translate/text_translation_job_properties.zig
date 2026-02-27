const InputDataConfig = @import("input_data_config.zig").InputDataConfig;
const JobDetails = @import("job_details.zig").JobDetails;
const JobStatus = @import("job_status.zig").JobStatus;
const OutputDataConfig = @import("output_data_config.zig").OutputDataConfig;
const TranslationSettings = @import("translation_settings.zig").TranslationSettings;

/// Provides information about a translation job.
pub const TextTranslationJobProperties = struct {
    /// The Amazon Resource Name (ARN) of an AWS Identity Access and Management
    /// (IAM) role
    /// that granted Amazon Translate read access to the job's input data.
    data_access_role_arn: ?[]const u8,

    /// The time at which the translation job ended.
    end_time: ?i64,

    /// The input configuration properties that were specified when the job was
    /// requested.
    input_data_config: ?InputDataConfig,

    /// The number of documents successfully and unsuccessfully processed during the
    /// translation
    /// job.
    job_details: ?JobDetails,

    /// The ID of the translation job.
    job_id: ?[]const u8,

    /// The user-defined name of the translation job.
    job_name: ?[]const u8,

    /// The status of the translation job.
    job_status: ?JobStatus,

    /// An explanation of any errors that may have occurred during the translation
    /// job.
    message: ?[]const u8,

    /// The output configuration properties that were specified when the job was
    /// requested.
    output_data_config: ?OutputDataConfig,

    /// A list containing the names of the parallel data resources applied to the
    /// translation
    /// job.
    parallel_data_names: ?[]const []const u8,

    /// Settings that modify the translation output.
    settings: ?TranslationSettings,

    /// The language code of the language of the source text. The language must be a
    /// language
    /// supported by Amazon Translate.
    source_language_code: ?[]const u8,

    /// The time at which the translation job was submitted.
    submitted_time: ?i64,

    /// The language code of the language of the target text. The language must be a
    /// language
    /// supported by Amazon Translate.
    target_language_codes: ?[]const []const u8,

    /// A list containing the names of the terminologies applied to a translation
    /// job. Only one
    /// terminology can be applied per StartTextTranslationJob request at this
    /// time.
    terminology_names: ?[]const []const u8,

    pub const json_field_names = .{
        .data_access_role_arn = "DataAccessRoleArn",
        .end_time = "EndTime",
        .input_data_config = "InputDataConfig",
        .job_details = "JobDetails",
        .job_id = "JobId",
        .job_name = "JobName",
        .job_status = "JobStatus",
        .message = "Message",
        .output_data_config = "OutputDataConfig",
        .parallel_data_names = "ParallelDataNames",
        .settings = "Settings",
        .source_language_code = "SourceLanguageCode",
        .submitted_time = "SubmittedTime",
        .target_language_codes = "TargetLanguageCodes",
        .terminology_names = "TerminologyNames",
    };
};
