const MedicalContentIdentificationType = @import("medical_content_identification_type.zig").MedicalContentIdentificationType;
const LanguageCode = @import("language_code.zig").LanguageCode;
const Media = @import("media.zig").Media;
const MediaFormat = @import("media_format.zig").MediaFormat;
const MedicalTranscriptionSetting = @import("medical_transcription_setting.zig").MedicalTranscriptionSetting;
const Specialty = @import("specialty.zig").Specialty;
const Tag = @import("tag.zig").Tag;
const MedicalTranscript = @import("medical_transcript.zig").MedicalTranscript;
const TranscriptionJobStatus = @import("transcription_job_status.zig").TranscriptionJobStatus;
const Type = @import("type.zig").Type;

/// Provides detailed information about a medical transcription job.
///
/// To view the status of the specified medical transcription job, check the
/// `TranscriptionJobStatus` field. If the status is `COMPLETED`,
/// the job is finished and you can find the results at the location specified
/// in
/// `TranscriptFileUri`. If the status is `FAILED`,
/// `FailureReason` provides details on why your transcription job
/// failed.
pub const MedicalTranscriptionJob = struct {
    /// The date and time the specified medical transcription job finished
    /// processing.
    ///
    /// Timestamps are in the format `YYYY-MM-DD'T'HH:MM:SS.SSSSSS-UTC`. For
    /// example, `2022-05-04T12:33:13.922000-07:00` represents a transcription job
    /// that started processing at 12:33 PM UTC-7 on May 4, 2022.
    completion_time: ?i64,

    /// Indicates whether content identification was enabled for your transcription
    /// request.
    content_identification_type: ?MedicalContentIdentificationType,

    /// The date and time the specified medical transcription job request was made.
    ///
    /// Timestamps are in the format `YYYY-MM-DD'T'HH:MM:SS.SSSSSS-UTC`. For
    /// example, `2022-05-04T12:32:58.761000-07:00` represents a transcription job
    /// that started processing at 12:32 PM UTC-7 on May 4, 2022.
    creation_time: ?i64,

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
    /// The sample rate must be between 16,000 and 48,000 hertz.
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
    failure_reason: ?[]const u8,

    /// The language code used to create your medical transcription job. US English
    /// (`en-US`) is the only supported language for medical
    /// transcriptions.
    language_code: ?LanguageCode,

    media: ?Media,

    /// The format of the input media file.
    media_format: ?MediaFormat,

    /// The sample rate, in hertz, of the audio track in your input media file.
    media_sample_rate_hertz: ?i32,

    /// The name of the medical transcription job. Job names are case sensitive and
    /// must be
    /// unique within an Amazon Web Services account.
    medical_transcription_job_name: ?[]const u8,

    /// Provides information on any additional settings that were included in your
    /// request.
    /// Additional settings include channel identification, alternative
    /// transcriptions, speaker
    /// partitioning, custom vocabularies, and custom vocabulary filters.
    settings: ?MedicalTranscriptionSetting,

    /// Describes the medical specialty represented in your media.
    specialty: ?Specialty,

    /// The date and time the specified medical transcription job began processing.
    ///
    /// Timestamps are in the format `YYYY-MM-DD'T'HH:MM:SS.SSSSSS-UTC`. For
    /// example, `2022-05-04T12:32:58.789000-07:00` represents a transcription job
    /// that started processing at 12:32 PM UTC-7 on May 4, 2022.
    start_time: ?i64,

    /// The tags, each in the form of a key:value pair, assigned to the specified
    /// medical
    /// transcription job.
    tags: ?[]const Tag,

    /// Provides you with the Amazon S3 URI you can use to access your
    /// transcript.
    transcript: ?MedicalTranscript,

    /// Provides the status of the specified medical transcription job.
    ///
    /// If the status is `COMPLETED`, the job is finished and you can find the
    /// results at the location specified in `TranscriptFileUri`. If the status is
    /// `FAILED`, `FailureReason` provides details on why your
    /// transcription job failed.
    transcription_job_status: ?TranscriptionJobStatus,

    /// Indicates whether the input media is a dictation or a conversation, as
    /// specified in
    /// the `StartMedicalTranscriptionJob` request.
    @"type": ?Type,

    pub const json_field_names = .{
        .completion_time = "CompletionTime",
        .content_identification_type = "ContentIdentificationType",
        .creation_time = "CreationTime",
        .failure_reason = "FailureReason",
        .language_code = "LanguageCode",
        .media = "Media",
        .media_format = "MediaFormat",
        .media_sample_rate_hertz = "MediaSampleRateHertz",
        .medical_transcription_job_name = "MedicalTranscriptionJobName",
        .settings = "Settings",
        .specialty = "Specialty",
        .start_time = "StartTime",
        .tags = "Tags",
        .transcript = "Transcript",
        .transcription_job_status = "TranscriptionJobStatus",
        .@"type" = "Type",
    };
};
