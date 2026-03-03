const ContentRedaction = @import("content_redaction.zig").ContentRedaction;
const LanguageCode = @import("language_code.zig").LanguageCode;
const LanguageCodeItem = @import("language_code_item.zig").LanguageCodeItem;
const ModelSettings = @import("model_settings.zig").ModelSettings;
const OutputLocationType = @import("output_location_type.zig").OutputLocationType;
const ToxicityDetectionSettings = @import("toxicity_detection_settings.zig").ToxicityDetectionSettings;
const TranscriptionJobStatus = @import("transcription_job_status.zig").TranscriptionJobStatus;

/// Provides detailed information about a specific transcription job.
pub const TranscriptionJobSummary = struct {
    /// The date and time the specified transcription job finished processing.
    ///
    /// Timestamps are in the format `YYYY-MM-DD'T'HH:MM:SS.SSSSSS-UTC`. For
    /// example, `2022-05-04T12:33:13.922000-07:00` represents a transcription job
    /// that started processing at 12:33 PM UTC-7 on May 4, 2022.
    completion_time: ?i64 = null,

    /// The content redaction settings of the transcription job.
    content_redaction: ?ContentRedaction = null,

    /// The date and time the specified transcription job request was made.
    ///
    /// Timestamps are in the format `YYYY-MM-DD'T'HH:MM:SS.SSSSSS-UTC`. For
    /// example, `2022-05-04T12:32:58.761000-07:00` represents a transcription job
    /// that started processing at 12:32 PM UTC-7 on May 4, 2022.
    creation_time: ?i64 = null,

    /// If `TranscriptionJobStatus` is `FAILED`,
    /// `FailureReason` contains information about why the transcription job
    /// failed. See also: [Common
    /// Errors](https://docs.aws.amazon.com/transcribe/latest/APIReference/CommonErrors.html).
    failure_reason: ?[]const u8 = null,

    /// The confidence score associated with the language identified in your media
    /// file.
    ///
    /// Confidence scores are values between 0 and 1; a larger value indicates a
    /// higher
    /// probability that the identified language correctly matches the language
    /// spoken in your
    /// media.
    identified_language_score: ?f32 = null,

    /// Indicates whether automatic language identification was enabled (`TRUE`)
    /// for the specified transcription job.
    identify_language: ?bool = null,

    /// Indicates whether automatic multi-language identification was enabled
    /// (`TRUE`) for the specified transcription job.
    identify_multiple_languages: ?bool = null,

    /// The language code used to create your transcription.
    language_code: ?LanguageCode = null,

    /// The language codes used to create your transcription job. This parameter is
    /// used with
    /// multi-language identification. For single-language identification, the
    /// singular version
    /// of this parameter, `LanguageCode`, is present.
    language_codes: ?[]const LanguageCodeItem = null,

    model_settings: ?ModelSettings = null,

    /// Indicates where the specified transcription output is stored.
    ///
    /// If the value is `CUSTOMER_BUCKET`, the location is the Amazon S3
    /// bucket you specified using the `OutputBucketName` parameter in your request.
    /// If you also included
    /// `OutputKey` in your request, your output is located in the path you
    /// specified in your request.
    ///
    /// If the value is `SERVICE_BUCKET`, the location is a service-managed Amazon
    /// S3 bucket. To access a transcript stored in a service-managed bucket, use
    /// the
    /// URI shown in the `TranscriptFileUri` or
    /// `RedactedTranscriptFileUri` field.
    output_location_type: ?OutputLocationType = null,

    /// The date and time your transcription job began processing.
    ///
    /// Timestamps are in the format `YYYY-MM-DD'T'HH:MM:SS.SSSSSS-UTC`. For
    /// example, `2022-05-04T12:32:58.789000-07:00` represents a transcription job
    /// that started processing at 12:32 PM UTC-7 on May 4, 2022.
    start_time: ?i64 = null,

    /// Indicates whether toxicity detection was enabled for the specified
    /// transcription
    /// job.
    toxicity_detection: ?[]const ToxicityDetectionSettings = null,

    /// The name of the transcription job. Job names are case sensitive and must be
    /// unique
    /// within an Amazon Web Services account.
    transcription_job_name: ?[]const u8 = null,

    /// Provides the status of your transcription job.
    ///
    /// If the status is `COMPLETED`, the job is finished and you can find the
    /// results at the location specified in `TranscriptFileUri` (or
    /// `RedactedTranscriptFileUri`, if you requested transcript redaction). If
    /// the status is `FAILED`, `FailureReason` provides details on why
    /// your transcription job failed.
    transcription_job_status: ?TranscriptionJobStatus = null,

    pub const json_field_names = .{
        .completion_time = "CompletionTime",
        .content_redaction = "ContentRedaction",
        .creation_time = "CreationTime",
        .failure_reason = "FailureReason",
        .identified_language_score = "IdentifiedLanguageScore",
        .identify_language = "IdentifyLanguage",
        .identify_multiple_languages = "IdentifyMultipleLanguages",
        .language_code = "LanguageCode",
        .language_codes = "LanguageCodes",
        .model_settings = "ModelSettings",
        .output_location_type = "OutputLocationType",
        .start_time = "StartTime",
        .toxicity_detection = "ToxicityDetection",
        .transcription_job_name = "TranscriptionJobName",
        .transcription_job_status = "TranscriptionJobStatus",
    };
};
