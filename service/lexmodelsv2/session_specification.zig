const ConversationEndState = @import("conversation_end_state.zig").ConversationEndState;
const InvokedIntentSample = @import("invoked_intent_sample.zig").InvokedIntentSample;
const AnalyticsModality = @import("analytics_modality.zig").AnalyticsModality;

/// An object containing information about a specific session.
pub const SessionSpecification = struct {
    /// The identifier of the alias of the bot that the session was held with.
    bot_alias_id: ?[]const u8 = null,

    /// The version of the bot that the session was held with.
    bot_version: ?[]const u8 = null,

    /// The channel that is integrated with the bot that the session was held with.
    channel: ?[]const u8 = null,

    /// The duration of the conversation in seconds. A conversation is defined as a
    /// unique combination of a `sessionId` and an `originatingRequestId`.
    conversation_duration_seconds: ?i64 = null,

    /// The final state of the conversation. A conversation is defined as a unique
    /// combination of a `sessionId` and an `originatingRequestId`.
    conversation_end_state: ?ConversationEndState = null,

    /// The date and time when the conversation ended. A conversation is defined as
    /// a unique combination of a `sessionId` and an `originatingRequestId`.
    conversation_end_time: ?i64 = null,

    /// The date and time when the conversation began. A conversation is defined as
    /// a unique combination of a `sessionId` and an `originatingRequestId`.
    conversation_start_time: ?i64 = null,

    /// A list of objects containing the name of an intent that was invoked.
    invoked_intent_samples: ?[]const InvokedIntentSample = null,

    /// The locale of the bot that the session was held with.
    locale_id: ?[]const u8 = null,

    /// The mode of the session. The possible values are as follows:
    ///
    /// * `Speech` – The session was spoken.
    ///
    /// * `Text` – The session was written.
    ///
    /// * `DTMF` – The session used a touch-tone keypad (Dual Tone Multi-Frequency).
    ///
    /// * `MultiMode` – The session used multiple modes.
    mode: ?AnalyticsModality = null,

    /// The number of turns that the session took.
    number_of_turns: ?i64 = null,

    /// The identifier of the first request in a session.
    originating_request_id: ?[]const u8 = null,

    /// The identifier of the session.
    session_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .bot_alias_id = "botAliasId",
        .bot_version = "botVersion",
        .channel = "channel",
        .conversation_duration_seconds = "conversationDurationSeconds",
        .conversation_end_state = "conversationEndState",
        .conversation_end_time = "conversationEndTime",
        .conversation_start_time = "conversationStartTime",
        .invoked_intent_samples = "invokedIntentSamples",
        .locale_id = "localeId",
        .mode = "mode",
        .number_of_turns = "numberOfTurns",
        .originating_request_id = "originatingRequestId",
        .session_id = "sessionId",
    };
};
