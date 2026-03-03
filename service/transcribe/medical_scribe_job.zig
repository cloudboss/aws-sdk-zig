const MedicalScribeChannelDefinition = @import("medical_scribe_channel_definition.zig").MedicalScribeChannelDefinition;
const MedicalScribeLanguageCode = @import("medical_scribe_language_code.zig").MedicalScribeLanguageCode;
const Media = @import("media.zig").Media;
const MedicalScribeJobStatus = @import("medical_scribe_job_status.zig").MedicalScribeJobStatus;
const MedicalScribeOutput = @import("medical_scribe_output.zig").MedicalScribeOutput;
const MedicalScribeSettings = @import("medical_scribe_settings.zig").MedicalScribeSettings;
const Tag = @import("tag.zig").Tag;

/// Provides detailed information about a Medical Scribe job.
///
/// To view the status of the specified Medical Scribe job, check the
/// `MedicalScribeJobStatus` field. If the status is `COMPLETED`,
/// the job is finished and you can find the results at the locations specified
/// in
/// `MedicalScribeOutput`. If the status is `FAILED`,
/// `FailureReason` provides details on why your Medical Scribe job
/// failed.
pub const MedicalScribeJob = struct {
    /// Makes it possible to specify which speaker is on which channel. For example,
    /// if the clinician
    /// is the first participant to speak, you would set `ChannelId` of the first
    /// `ChannelDefinition`
    /// in the list to `0` (to indicate the first channel) and `ParticipantRole` to
    /// `CLINICIAN` (to indicate that it's the clinician speaking).
    /// Then you would set the `ChannelId` of the second `ChannelDefinition` in the
    /// list to
    /// `1` (to indicate the second channel) and `ParticipantRole` to
    /// `PATIENT` (to indicate that it's the patient speaking).
    channel_definitions: ?[]const MedicalScribeChannelDefinition = null,

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

    /// The Amazon Resource Name (ARN) of an IAM role that has permissions to
    /// access the Amazon S3 bucket that contains your input files,
    /// write to the output bucket, and use your KMS key if supplied.
    /// If the role that you specify doesn’t have the appropriate permissions your
    /// request fails.
    ///
    /// IAM role ARNs have the format
    /// `arn:partition:iam::account:role/role-name-with-path`. For example:
    /// `arn:aws:iam::111122223333:role/Admin`.
    ///
    /// For more information, see [IAM
    /// ARNs](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html#identifiers-arns).
    data_access_role_arn: ?[]const u8 = null,

    /// If `MedicalScribeJobStatus` is `FAILED`,
    /// `FailureReason` contains information about why the transcription job
    /// failed. See also: [Common
    /// Errors](https://docs.aws.amazon.com/transcribe/latest/APIReference/CommonErrors.html).
    failure_reason: ?[]const u8 = null,

    /// The language code used to create your Medical Scribe job. US English
    /// (`en-US`) is the only supported language for Medical Scribe jobs.
    language_code: ?MedicalScribeLanguageCode = null,

    media: ?Media = null,

    /// Indicates whether the `MedicalScribeContext` object was provided when the
    /// Medical Scribe job was started.
    medical_scribe_context_provided: ?bool = null,

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

    /// The location of the output of your Medical Scribe job.
    /// `ClinicalDocumentUri` holds the Amazon S3 URI for the Clinical Document
    /// and `TranscriptFileUri` holds the Amazon S3 URI for the Transcript.
    medical_scribe_output: ?MedicalScribeOutput = null,

    /// Makes it possible to control how your Medical Scribe job is processed using
    /// a
    /// `MedicalScribeSettings` object. Specify `ChannelIdentification` if
    /// `ChannelDefinitions` are set. Enabled `ShowSpeakerLabels` if
    /// `ChannelIdentification`
    /// and `ChannelDefinitions` are not set. One and only one of
    /// `ChannelIdentification` and `ShowSpeakerLabels`
    /// must be set. If `ShowSpeakerLabels` is set, `MaxSpeakerLabels` must also be
    /// set. Use `Settings`
    /// to specify a vocabulary or vocabulary filter or both using `VocabularyName`,
    /// `VocabularyFilterName`.
    /// `VocabularyFilterMethod` must be specified if `VocabularyFilterName` is set.
    settings: ?MedicalScribeSettings = null,

    /// The date and time your Medical Scribe job began processing.
    ///
    /// Timestamps are in the format `YYYY-MM-DD'T'HH:MM:SS.SSSSSS-UTC`. For
    /// example, `2022-05-04T12:32:58.789000-07:00` represents a Medical Scribe job
    /// that started processing at 12:32 PM UTC-7 on May 4, 2022.
    start_time: ?i64 = null,

    /// Adds one or more custom tags, each in the form of a key:value pair, to the
    /// Medical Scribe job.
    ///
    /// To learn more about using tags with Amazon Transcribe, refer to [Tagging
    /// resources](https://docs.aws.amazon.com/transcribe/latest/dg/tagging.html).
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .channel_definitions = "ChannelDefinitions",
        .completion_time = "CompletionTime",
        .creation_time = "CreationTime",
        .data_access_role_arn = "DataAccessRoleArn",
        .failure_reason = "FailureReason",
        .language_code = "LanguageCode",
        .media = "Media",
        .medical_scribe_context_provided = "MedicalScribeContextProvided",
        .medical_scribe_job_name = "MedicalScribeJobName",
        .medical_scribe_job_status = "MedicalScribeJobStatus",
        .medical_scribe_output = "MedicalScribeOutput",
        .settings = "Settings",
        .start_time = "StartTime",
        .tags = "Tags",
    };
};
