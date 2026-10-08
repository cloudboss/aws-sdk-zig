const MedicalScribeChannelDefinition = @import("medical_scribe_channel_definition.zig").MedicalScribeChannelDefinition;
const MedicalScribeLanguageCode = @import("medical_scribe_language_code.zig").MedicalScribeLanguageCode;
const MedicalScribeMediaEncoding = @import("medical_scribe_media_encoding.zig").MedicalScribeMediaEncoding;
const MedicalScribePostStreamActionsResult = @import("medical_scribe_post_stream_actions_result.zig").MedicalScribePostStreamActionsResult;
const MedicalScribePostStreamActionSettingsResponse = @import("medical_scribe_post_stream_action_settings_response.zig").MedicalScribePostStreamActionSettingsResponse;
const MedicalScribeStreamStatus = @import("medical_scribe_stream_status.zig").MedicalScribeStreamStatus;

/// Detailed information about a Medical Scribe listening session
pub const MedicalScribeListeningSessionDetails = struct {
    /// Channel definitions for the audio stream
    channel_definitions: ?[]const MedicalScribeChannelDefinition = null,

    /// The Domain identifier
    domain_id: ?[]const u8 = null,

    /// Indicates whether encounter context was provided
    encounter_context_provided: ?bool = null,

    /// The Language Code for the audio in the session
    language_code: ?MedicalScribeLanguageCode = null,

    /// The encoding for the input audio
    media_encoding: ?MedicalScribeMediaEncoding = null,

    /// The sample rate of the input audio
    media_sample_rate_hertz: ?i32 = null,

    /// Results of post-stream actions
    post_stream_action_result: ?MedicalScribePostStreamActionsResult = null,

    /// Settings for post-stream actions
    post_stream_action_settings: ?MedicalScribePostStreamActionSettingsResponse = null,

    /// The Session identifier
    session_id: ?[]const u8 = null,

    /// The timestamp when the stream was created
    stream_creation_time: ?i64 = null,

    /// The timestamp when the stream ended
    stream_end_time: ?i64 = null,

    /// The current status of the stream
    stream_status: ?MedicalScribeStreamStatus = null,

    /// The Subscription identifier
    subscription_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .channel_definitions = "channelDefinitions",
        .domain_id = "domainId",
        .encounter_context_provided = "encounterContextProvided",
        .language_code = "languageCode",
        .media_encoding = "mediaEncoding",
        .media_sample_rate_hertz = "mediaSampleRateHertz",
        .post_stream_action_result = "postStreamActionResult",
        .post_stream_action_settings = "postStreamActionSettings",
        .session_id = "sessionId",
        .stream_creation_time = "streamCreationTime",
        .stream_end_time = "streamEndTime",
        .stream_status = "streamStatus",
        .subscription_id = "subscriptionId",
    };
};
