const CallAnalyticsJobDetails = @import("call_analytics_job_details.zig").CallAnalyticsJobDetails;
const CallAnalyticsJobStatus = @import("call_analytics_job_status.zig").CallAnalyticsJobStatus;
const LanguageCode = @import("language_code.zig").LanguageCode;

/// Provides detailed information about a specific Call Analytics job.
pub const CallAnalyticsJobSummary = struct {
    /// Provides detailed information about a call analytics job, including
    /// information about skipped analytics features.
    call_analytics_job_details: ?CallAnalyticsJobDetails = null,

    /// The name of the Call Analytics job. Job names are case sensitive and must be
    /// unique
    /// within an Amazon Web Services account.
    call_analytics_job_name: ?[]const u8 = null,

    /// Provides the status of your Call Analytics job.
    ///
    /// If the status is `COMPLETED`, the job is finished and you can find the
    /// results at the location specified in `TranscriptFileUri` (or
    /// `RedactedTranscriptFileUri`, if you requested transcript redaction). If
    /// the status is `FAILED`, `FailureReason` provides details on why
    /// your transcription job failed.
    call_analytics_job_status: ?CallAnalyticsJobStatus = null,

    /// The date and time the specified Call Analytics job finished processing.
    ///
    /// Timestamps are in the format `YYYY-MM-DD'T'HH:MM:SS.SSSSSS-UTC`. For
    /// example, `2022-05-04T12:33:13.922000-07:00` represents a transcription job
    /// that started processing at 12:33 PM UTC-7 on May 4, 2022.
    completion_time: ?i64 = null,

    /// The date and time the specified Call Analytics job request was made.
    ///
    /// Timestamps are in the format `YYYY-MM-DD'T'HH:MM:SS.SSSSSS-UTC`. For
    /// example, `2022-05-04T12:32:58.761000-07:00` represents a transcription job
    /// that started processing at 12:32 PM UTC-7 on May 4, 2022.
    creation_time: ?i64 = null,

    /// If `CallAnalyticsJobStatus` is `FAILED`,
    /// `FailureReason` contains information about why the Call Analytics job
    /// failed. See also: [Common
    /// Errors](https://docs.aws.amazon.com/transcribe/latest/APIReference/CommonErrors.html).
    failure_reason: ?[]const u8 = null,

    /// The language code used to create your Call Analytics transcription.
    language_code: ?LanguageCode = null,

    /// The date and time your Call Analytics job began processing.
    ///
    /// Timestamps are in the format `YYYY-MM-DD'T'HH:MM:SS.SSSSSS-UTC`. For
    /// example, `2022-05-04T12:32:58.789000-07:00` represents a transcription job
    /// that started processing at 12:32 PM UTC-7 on May 4, 2022.
    start_time: ?i64 = null,

    pub const json_field_names = .{
        .call_analytics_job_details = "CallAnalyticsJobDetails",
        .call_analytics_job_name = "CallAnalyticsJobName",
        .call_analytics_job_status = "CallAnalyticsJobStatus",
        .completion_time = "CompletionTime",
        .creation_time = "CreationTime",
        .failure_reason = "FailureReason",
        .language_code = "LanguageCode",
        .start_time = "StartTime",
    };
};
