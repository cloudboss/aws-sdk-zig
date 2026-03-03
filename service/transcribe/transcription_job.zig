const aws = @import("aws");

const ContentRedaction = @import("content_redaction.zig").ContentRedaction;
const JobExecutionSettings = @import("job_execution_settings.zig").JobExecutionSettings;
const LanguageCode = @import("language_code.zig").LanguageCode;
const LanguageCodeItem = @import("language_code_item.zig").LanguageCodeItem;
const LanguageIdSettings = @import("language_id_settings.zig").LanguageIdSettings;
const Media = @import("media.zig").Media;
const MediaFormat = @import("media_format.zig").MediaFormat;
const ModelSettings = @import("model_settings.zig").ModelSettings;
const Settings = @import("settings.zig").Settings;
const SubtitlesOutput = @import("subtitles_output.zig").SubtitlesOutput;
const Tag = @import("tag.zig").Tag;
const ToxicityDetectionSettings = @import("toxicity_detection_settings.zig").ToxicityDetectionSettings;
const Transcript = @import("transcript.zig").Transcript;
const TranscriptionJobStatus = @import("transcription_job_status.zig").TranscriptionJobStatus;

/// Provides detailed information about a transcription job.
///
/// To view the status of the specified transcription job, check the
/// `TranscriptionJobStatus` field. If the status is `COMPLETED`,
/// the job is finished and you can find the results at the location specified
/// in
/// `TranscriptFileUri`. If the status is `FAILED`,
/// `FailureReason` provides details on why your transcription job
/// failed.
///
/// If you enabled content redaction, the redacted transcript can be found at
/// the location
/// specified in `RedactedTranscriptFileUri`.
pub const TranscriptionJob = struct {
    /// The date and time the specified transcription job finished processing.
    ///
    /// Timestamps are in the format `YYYY-MM-DD'T'HH:MM:SS.SSSSSS-UTC`. For
    /// example, `2022-05-04T12:33:13.922000-07:00` represents a transcription job
    /// that started processing at 12:33 PM UTC-7 on May 4, 2022.
    completion_time: ?i64 = null,

    /// Indicates whether redaction was enabled in your transcript.
    content_redaction: ?ContentRedaction = null,

    /// The date and time the specified transcription job request was made.
    ///
    /// Timestamps are in the format `YYYY-MM-DD'T'HH:MM:SS.SSSSSS-UTC`. For
    /// example, `2022-05-04T12:32:58.761000-07:00` represents a transcription job
    /// that started processing at 12:32 PM UTC-7 on May 4, 2022.
    creation_time: ?i64 = null,

    /// If `TranscriptionJobStatus` is `FAILED`,
    /// `FailureReason` contains information about why the transcription job
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

    /// Indicates whether automatic language identification was enabled (`TRUE`)
    /// for the specified transcription job.
    identify_language: ?bool = null,

    /// Indicates whether automatic multi-language identification was enabled
    /// (`TRUE`) for the specified transcription job.
    identify_multiple_languages: ?bool = null,

    /// Provides information about how your transcription job was processed. This
    /// parameter
    /// shows if your request was queued and what data access role was used.
    job_execution_settings: ?JobExecutionSettings = null,

    /// The language code used to create your transcription job. This parameter is
    /// used with
    /// single-language identification. For multi-language identification requests,
    /// refer to the
    /// plural version of this parameter, `LanguageCodes`.
    language_code: ?LanguageCode = null,

    /// The language codes used to create your transcription job. This parameter is
    /// used with
    /// multi-language identification. For single-language identification requests,
    /// refer to the
    /// singular version of this parameter, `LanguageCode`.
    language_codes: ?[]const LanguageCodeItem = null,

    /// Provides the name and language of all custom language models, custom
    /// vocabularies, and
    /// custom vocabulary filters that you included in your request.
    language_id_settings: ?[]const aws.map.MapEntry(LanguageIdSettings) = null,

    /// Provides the language codes you specified in your request.
    language_options: ?[]const LanguageCode = null,

    /// Provides the Amazon S3 location of the media file you used in your
    /// request.
    media: ?Media = null,

    /// The format of the input media file.
    media_format: ?MediaFormat = null,

    /// The sample rate, in hertz, of the audio track in your input media file.
    media_sample_rate_hertz: ?i32 = null,

    /// Provides information on the custom language model you included in your
    /// request.
    model_settings: ?ModelSettings = null,

    /// Provides information on any additional settings that were included in your
    /// request.
    /// Additional settings include channel identification, alternative
    /// transcriptions, speaker
    /// partitioning, custom vocabularies, and custom vocabulary filters.
    settings: ?Settings = null,

    /// The date and time the specified transcription job began processing.
    ///
    /// Timestamps are in the format `YYYY-MM-DD'T'HH:MM:SS.SSSSSS-UTC`. For
    /// example, `2022-05-04T12:32:58.789000-07:00` represents a transcription job
    /// that started processing at 12:32 PM UTC-7 on May 4, 2022.
    start_time: ?i64 = null,

    /// Indicates whether subtitles were generated with your transcription.
    subtitles: ?SubtitlesOutput = null,

    /// The tags, each in the form of a key:value pair, assigned to the specified
    /// transcription job.
    tags: ?[]const Tag = null,

    /// Provides information about the toxicity detection settings applied to your
    /// transcription.
    toxicity_detection: ?[]const ToxicityDetectionSettings = null,

    /// Provides you with the Amazon S3 URI you can use to access your
    /// transcript.
    transcript: ?Transcript = null,

    /// The name of the transcription job. Job names are case sensitive and must be
    /// unique
    /// within an Amazon Web Services account.
    transcription_job_name: ?[]const u8 = null,

    /// Provides the status of the specified transcription job.
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
        .job_execution_settings = "JobExecutionSettings",
        .language_code = "LanguageCode",
        .language_codes = "LanguageCodes",
        .language_id_settings = "LanguageIdSettings",
        .language_options = "LanguageOptions",
        .media = "Media",
        .media_format = "MediaFormat",
        .media_sample_rate_hertz = "MediaSampleRateHertz",
        .model_settings = "ModelSettings",
        .settings = "Settings",
        .start_time = "StartTime",
        .subtitles = "Subtitles",
        .tags = "Tags",
        .toxicity_detection = "ToxicityDetection",
        .transcript = "Transcript",
        .transcription_job_name = "TranscriptionJobName",
        .transcription_job_status = "TranscriptionJobStatus",
    };
};
