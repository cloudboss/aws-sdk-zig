const MedicalScribeChannelDefinition = @import("medical_scribe_channel_definition.zig").MedicalScribeChannelDefinition;
const MedicalScribeEncryptionSettings = @import("medical_scribe_encryption_settings.zig").MedicalScribeEncryptionSettings;
const MedicalScribeLanguageCode = @import("medical_scribe_language_code.zig").MedicalScribeLanguageCode;
const MedicalScribeMediaEncoding = @import("medical_scribe_media_encoding.zig").MedicalScribeMediaEncoding;
const MedicalScribePostStreamAnalyticsResult = @import("medical_scribe_post_stream_analytics_result.zig").MedicalScribePostStreamAnalyticsResult;
const MedicalScribePostStreamAnalyticsSettings = @import("medical_scribe_post_stream_analytics_settings.zig").MedicalScribePostStreamAnalyticsSettings;
const MedicalScribeStreamStatus = @import("medical_scribe_stream_status.zig").MedicalScribeStreamStatus;
const MedicalScribeVocabularyFilterMethod = @import("medical_scribe_vocabulary_filter_method.zig").MedicalScribeVocabularyFilterMethod;

/// Contains details about a Amazon Web Services HealthScribe streaming session.
pub const MedicalScribeStreamDetails = struct {
    /// The Channel Definitions of the HealthScribe streaming session.
    channel_definitions: ?[]const MedicalScribeChannelDefinition,

    /// The Encryption Settings of the HealthScribe streaming session.
    encryption_settings: ?MedicalScribeEncryptionSettings,

    /// The Language Code of the HealthScribe streaming session.
    language_code: ?MedicalScribeLanguageCode,

    /// The Media Encoding of the HealthScribe streaming session.
    media_encoding: ?MedicalScribeMediaEncoding,

    /// The sample rate (in hertz) of the HealthScribe streaming session.
    media_sample_rate_hertz: ?i32,

    /// Indicates whether the `MedicalScribeContext` object was provided when the
    /// stream was started.
    medical_scribe_context_provided: ?bool,

    /// The result of post-stream analytics for the HealthScribe streaming session.
    post_stream_analytics_result: ?MedicalScribePostStreamAnalyticsResult,

    /// The post-stream analytics settings of the HealthScribe streaming session.
    post_stream_analytics_settings: ?MedicalScribePostStreamAnalyticsSettings,

    /// The Amazon Resource Name (ARN) of the role used in the HealthScribe
    /// streaming session.
    resource_access_role_arn: ?[]const u8,

    /// The identifier of the HealthScribe streaming session.
    session_id: ?[]const u8,

    /// The date and time when the HealthScribe streaming session was created.
    stream_created_at: ?i64,

    /// The date and time when the HealthScribe streaming session was ended.
    stream_ended_at: ?i64,

    /// The streaming status of the HealthScribe streaming session.
    ///
    /// Possible Values:
    ///
    /// * `IN_PROGRESS`
    ///
    /// * `PAUSED`
    ///
    /// * `FAILED`
    ///
    /// * `COMPLETED`
    ///
    /// This status is specific to real-time streaming.
    /// A `COMPLETED` status doesn't mean that the post-stream analytics is
    /// complete.
    /// To get status of an analytics result, check the `Status` field for the
    /// analytics result within the
    /// `MedicalScribePostStreamAnalyticsResult`. For example, you can view the
    /// status of the
    /// `ClinicalNoteGenerationResult`.
    stream_status: ?MedicalScribeStreamStatus,

    /// The method of the vocabulary filter for the HealthScribe streaming session.
    vocabulary_filter_method: ?MedicalScribeVocabularyFilterMethod,

    /// The name of the vocabulary filter used for the HealthScribe streaming
    /// session .
    vocabulary_filter_name: ?[]const u8,

    /// The vocabulary name of the HealthScribe streaming session.
    vocabulary_name: ?[]const u8,

    pub const json_field_names = .{
        .channel_definitions = "ChannelDefinitions",
        .encryption_settings = "EncryptionSettings",
        .language_code = "LanguageCode",
        .media_encoding = "MediaEncoding",
        .media_sample_rate_hertz = "MediaSampleRateHertz",
        .medical_scribe_context_provided = "MedicalScribeContextProvided",
        .post_stream_analytics_result = "PostStreamAnalyticsResult",
        .post_stream_analytics_settings = "PostStreamAnalyticsSettings",
        .resource_access_role_arn = "ResourceAccessRoleArn",
        .session_id = "SessionId",
        .stream_created_at = "StreamCreatedAt",
        .stream_ended_at = "StreamEndedAt",
        .stream_status = "StreamStatus",
        .vocabulary_filter_method = "VocabularyFilterMethod",
        .vocabulary_filter_name = "VocabularyFilterName",
        .vocabulary_name = "VocabularyName",
    };
};
