const CallAnalyticsJobDetails = @import("call_analytics_job_details.zig").CallAnalyticsJobDetails;
const CallAnalyticsJobStatus = @import("call_analytics_job_status.zig").CallAnalyticsJobStatus;
const ChannelDefinition = @import("channel_definition.zig").ChannelDefinition;
const LanguageCode = @import("language_code.zig").LanguageCode;
const Media = @import("media.zig").Media;
const MediaFormat = @import("media_format.zig").MediaFormat;
const CallAnalyticsJobSettings = @import("call_analytics_job_settings.zig").CallAnalyticsJobSettings;
const Tag = @import("tag.zig").Tag;
const Transcript = @import("transcript.zig").Transcript;

/// Provides detailed information about a Call Analytics job.
///
/// To view the job's status, refer to `CallAnalyticsJobStatus`. If the status
/// is `COMPLETED`, the job is finished. You can find your completed transcript
/// at the URI specified in `TranscriptFileUri`. If the status is
/// `FAILED`, `FailureReason` provides details on why your
/// transcription job failed.
///
/// If you enabled personally identifiable information (PII) redaction, the
/// redacted
/// transcript appears at the location specified in
/// `RedactedTranscriptFileUri`.
///
/// If you chose to redact the audio in your media file, you can find your
/// redacted media
/// file at the location specified in the `RedactedMediaFileUri` field of your
/// response.
pub const CallAnalyticsJob = struct {
    /// Provides detailed information about a call analytics job, including
    /// information about skipped analytics features.
    call_analytics_job_details: ?CallAnalyticsJobDetails = null,

    /// The name of the Call Analytics job. Job names are case sensitive and must be
    /// unique
    /// within an Amazon Web Services account.
    call_analytics_job_name: ?[]const u8 = null,

    /// Provides the status of the specified Call Analytics job.
    ///
    /// If the status is `COMPLETED`, the job is finished and you can find the
    /// results at the location specified in `TranscriptFileUri` (or
    /// `RedactedTranscriptFileUri`, if you requested transcript redaction). If
    /// the status is `FAILED`, `FailureReason` provides details on why
    /// your transcription job failed.
    call_analytics_job_status: ?CallAnalyticsJobStatus = null,

    /// Indicates which speaker is on which channel.
    channel_definitions: ?[]const ChannelDefinition = null,

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

    /// The Amazon Resource Name (ARN) you included in your request.
    data_access_role_arn: ?[]const u8 = null,

    /// If `CallAnalyticsJobStatus` is `FAILED`,
    /// `FailureReason` contains information about why the Call Analytics job
    /// request failed.
    ///
    /// The `FailureReason` field contains one of the following values:
    ///
    /// * `Unsupported media format`.
    ///
    /// The media format specified in `MediaFormat` isn't valid. Refer to
    /// refer to the `MediaFormat` parameter for a list of supported
    /// formats.
    ///
    /// * `The media format provided does not match the detected media
    /// format`.
    ///
    /// The media format specified in `MediaFormat` doesn't match the
    /// format of the input file. Check the media format of your media file and
    /// correct
    /// the specified value.
    ///
    /// * `Invalid sample rate for audio file`.
    ///
    /// The sample rate specified in `MediaSampleRateHertz` isn't valid.
    /// The sample rate must be between 8,000 and 48,000 hertz.
    ///
    /// * `The sample rate provided does not match the detected sample
    /// rate`.
    ///
    /// The sample rate specified in `MediaSampleRateHertz` doesn't match
    /// the sample rate detected in your input media file. Check the sample rate of
    /// your
    /// media file and correct the specified value.
    ///
    /// * `Invalid file size: file size too large`.
    ///
    /// The size of your media file is larger than what Amazon Transcribe can
    /// process. For more information, refer to [Service
    /// quotas](https://docs.aws.amazon.com/general/latest/gr/transcribe.html#limits-amazon-transcribe).
    ///
    /// * `Invalid number of channels: number of channels too large`.
    ///
    /// Your audio contains more channels than Amazon Transcribe is able to process.
    /// For more information, refer to [Service
    /// quotas](https://docs.aws.amazon.com/general/latest/gr/transcribe.html#limits-amazon-transcribe).
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

    /// The language code used to create your Call Analytics job. For a list of
    /// supported
    /// languages and their associated language codes, refer to the [Supported
    /// languages](https://docs.aws.amazon.com/transcribe/latest/dg/supported-languages.html)
    /// table.
    ///
    /// If you do not know the language spoken in your media file, you can omit this
    /// field and
    /// let Amazon Transcribe automatically identify the language of your media. To
    /// improve the
    /// accuracy of language identification, you can include several language codes
    /// and Amazon Transcribe chooses the closest match for your transcription.
    language_code: ?LanguageCode = null,

    /// Provides the Amazon S3 location of the media file you used in your Call
    /// Analytics request.
    media: ?Media = null,

    /// The format of the input media file.
    media_format: ?MediaFormat = null,

    /// The sample rate, in hertz, of the audio track in your input media file.
    media_sample_rate_hertz: ?i32 = null,

    /// Provides information on any additional settings that were included in your
    /// request.
    /// Additional settings include content redaction and language identification
    /// settings.
    settings: ?CallAnalyticsJobSettings = null,

    /// The date and time the specified Call Analytics job began processing.
    ///
    /// Timestamps are in the format `YYYY-MM-DD'T'HH:MM:SS.SSSSSS-UTC`. For
    /// example, `2022-05-04T12:32:58.789000-07:00` represents a transcription job
    /// that started processing at 12:32 PM UTC-7 on May 4, 2022.
    start_time: ?i64 = null,

    /// The tags, each in the form of a key:value pair, assigned to the specified
    /// call analytics job.
    tags: ?[]const Tag = null,

    transcript: ?Transcript = null,

    pub const json_field_names = .{
        .call_analytics_job_details = "CallAnalyticsJobDetails",
        .call_analytics_job_name = "CallAnalyticsJobName",
        .call_analytics_job_status = "CallAnalyticsJobStatus",
        .channel_definitions = "ChannelDefinitions",
        .completion_time = "CompletionTime",
        .creation_time = "CreationTime",
        .data_access_role_arn = "DataAccessRoleArn",
        .failure_reason = "FailureReason",
        .identified_language_score = "IdentifiedLanguageScore",
        .language_code = "LanguageCode",
        .media = "Media",
        .media_format = "MediaFormat",
        .media_sample_rate_hertz = "MediaSampleRateHertz",
        .settings = "Settings",
        .start_time = "StartTime",
        .tags = "Tags",
        .transcript = "Transcript",
    };
};
