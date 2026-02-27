const MedicalScribeChannelDefinition = @import("medical_scribe_channel_definition.zig").MedicalScribeChannelDefinition;
const MedicalScribeEncryptionSettings = @import("medical_scribe_encryption_settings.zig").MedicalScribeEncryptionSettings;
const MedicalScribeContext = @import("medical_scribe_context.zig").MedicalScribeContext;
const MedicalScribePostStreamAnalyticsSettings = @import("medical_scribe_post_stream_analytics_settings.zig").MedicalScribePostStreamAnalyticsSettings;
const MedicalScribeVocabularyFilterMethod = @import("medical_scribe_vocabulary_filter_method.zig").MedicalScribeVocabularyFilterMethod;

/// Specify details to configure the streaming session, including channel
/// definitions, encryption settings, post-stream analytics
/// settings, resource access role ARN and vocabulary settings.
///
/// Whether you are starting a new session or resuming an existing session,
/// your first event must be a `MedicalScribeConfigurationEvent`.
/// If you are resuming a session, then this event must have the same
/// configurations that you provided to start the session.
pub const MedicalScribeConfigurationEvent = struct {
    /// Specify which speaker is on which audio channel.
    channel_definitions: ?[]const MedicalScribeChannelDefinition,

    /// Specify the encryption settings for your streaming session.
    encryption_settings: ?MedicalScribeEncryptionSettings,

    /// The `MedicalScribeContext` object that contains contextual information used
    /// to generate
    /// customized clinical notes.
    medical_scribe_context: ?MedicalScribeContext,

    /// Specify settings for post-stream analytics.
    post_stream_analytics_settings: MedicalScribePostStreamAnalyticsSettings,

    /// The Amazon Resource Name (ARN) of an IAM role that has permissions to access
    /// the Amazon S3 output
    /// bucket you specified, and use your KMS key if supplied. If the role that you
    /// specify doesn’t have the
    /// appropriate permissions, your request fails.
    ///
    /// IAM
    /// role ARNs have the format
    /// `arn:partition:iam::account:role/role-name-with-path`.
    /// For example: `arn:aws:iam::111122223333:role/Admin`.
    ///
    /// For more information, see [Amazon Web Services
    /// HealthScribe](https://docs.aws.amazon.com/transcribe/latest/dg/health-scribe-streaming.html).
    resource_access_role_arn: []const u8,

    /// Specify how you want your custom vocabulary filter applied to the streaming
    /// session.
    ///
    /// To replace words with `***`, specify `mask`.
    ///
    /// To delete words, specify `remove`.
    ///
    /// To flag words without changing them, specify `tag`.
    vocabulary_filter_method: ?MedicalScribeVocabularyFilterMethod,

    /// Specify the name of the custom vocabulary filter you want to include in your
    /// streaming session.
    /// Custom vocabulary filter names are case-sensitive.
    ///
    /// If you include `VocabularyFilterName` in the
    /// `MedicalScribeConfigurationEvent`,
    /// you must also include `VocabularyFilterMethod`.
    vocabulary_filter_name: ?[]const u8,

    /// Specify the name of the custom vocabulary you want to use for your streaming
    /// session.
    /// Custom vocabulary names are case-sensitive.
    vocabulary_name: ?[]const u8,

    pub const json_field_names = .{
        .channel_definitions = "ChannelDefinitions",
        .encryption_settings = "EncryptionSettings",
        .medical_scribe_context = "MedicalScribeContext",
        .post_stream_analytics_settings = "PostStreamAnalyticsSettings",
        .resource_access_role_arn = "ResourceAccessRoleArn",
        .vocabulary_filter_method = "VocabularyFilterMethod",
        .vocabulary_filter_name = "VocabularyFilterName",
        .vocabulary_name = "VocabularyName",
    };
};
