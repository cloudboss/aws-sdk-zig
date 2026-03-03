const MedicalScribeLanguageCode = @import("medical_scribe_language_code.zig").MedicalScribeLanguageCode;
const MedicalScribeJobStatus = @import("medical_scribe_job_status.zig").MedicalScribeJobStatus;

/// Provides detailed information about a specific Medical Scribe job.
pub const MedicalScribeJobSummary = struct {
    /// The date and time the specified Medical Scribe job finished processing.
    ///
    /// Timestamps are in the format `YYYY-MM-DD'T'HH:MM:SS.SSSSSS-UTC`. For
    /// example, `2022-05-04T12:32:58.761000-07:00` represents a Medical Scribe job
    /// that finished processing at 12:32 PM UTC-7 on May 4, 2022.
    completion_time: ?i64 = null,

    /// The date and time the specified Medical Scribe job request was made.
    ///
    /// Timestamps are in the format `YYYY-MM-DD'T'HH:MM:SS.SSSSSS-UTC`. For
    /// example, `2022-05-04T12:32:58.761000-07:00` represents a Medical Scribe job
    /// that started processing at 12:32 PM UTC-7 on May 4, 2022.
    creation_time: ?i64 = null,

    /// If `MedicalScribeJobStatus` is `FAILED`,
    /// `FailureReason` contains information about why the transcription job
    /// failed. See also: [Common
    /// Errors](https://docs.aws.amazon.com/transcribe/latest/APIReference/CommonErrors.html).
    failure_reason: ?[]const u8 = null,

    /// The language code used to create your Medical Scribe job. US English
    /// (`en-US`) is the only supported language for Medical Scribe jobs.
    language_code: ?MedicalScribeLanguageCode = null,

    /// The name of the Medical Scribe job. Job names are case sensitive and must be
    /// unique within an Amazon Web Services account.
    medical_scribe_job_name: ?[]const u8 = null,

    /// Provides the status of the specified Medical Scribe job.
    ///
    /// If the status is `COMPLETED`, the job is finished and you can find the
    /// results at the location specified in `MedicalScribeOutput` If
    /// the status is `FAILED`, `FailureReason` provides details on why
    /// your Medical Scribe job failed.
    medical_scribe_job_status: ?MedicalScribeJobStatus = null,

    /// The date and time your Medical Scribe job began processing.
    ///
    /// Timestamps are in the format `YYYY-MM-DD'T'HH:MM:SS.SSSSSS-UTC`. For
    /// example, `2022-05-04T12:32:58.789000-07:00` represents a Medical Scribe job
    /// that started processing at 12:32 PM UTC-7 on May 4, 2022.
    start_time: ?i64 = null,

    pub const json_field_names = .{
        .completion_time = "CompletionTime",
        .creation_time = "CreationTime",
        .failure_reason = "FailureReason",
        .language_code = "LanguageCode",
        .medical_scribe_job_name = "MedicalScribeJobName",
        .medical_scribe_job_status = "MedicalScribeJobStatus",
        .start_time = "StartTime",
    };
};
