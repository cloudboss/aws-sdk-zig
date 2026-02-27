const UtteranceBotResponse = @import("utterance_bot_response.zig").UtteranceBotResponse;
const IntentState = @import("intent_state.zig").IntentState;
const AnalyticsModality = @import("analytics_modality.zig").AnalyticsModality;

/// An object containing information about a specific utterance.
pub const UtteranceSpecification = struct {
    /// The name of the intent that the utterance is associated to.
    associated_intent_name: ?[]const u8,

    /// The name of the slot that the utterance is associated to.
    associated_slot_name: ?[]const u8,

    /// The duration in milliseconds of the audio associated with the utterance.
    audio_voice_duration_millis: ?i64,

    /// The identifier of the alias of the bot that the utterance was made to.
    bot_alias_id: ?[]const u8,

    /// The identifier for the audio of the bot response.
    bot_response_audio_voice_id: ?[]const u8,

    /// A list of objects containing information about the bot response to the
    /// utterance.
    bot_responses: ?[]const UtteranceBotResponse,

    /// The version of the bot that the utterance was made to.
    bot_version: ?[]const u8,

    /// The channel that is integrated with the bot that the utterance was made to.
    channel: ?[]const u8,

    /// The date and time when the conversation in which the utterance took place
    /// ended. A conversation is defined as a unique combination of a `sessionId`
    /// and an `originatingRequestId`.
    conversation_end_time: ?i64,

    /// The date and time when the conversation in which the utterance took place
    /// began. A conversation is defined as a unique combination of a `sessionId`
    /// and an `originatingRequestId`.
    conversation_start_time: ?i64,

    /// The type of dialog action that the utterance is associated to. See the
    /// `type` field in
    /// [DialogAction](https://docs.aws.amazon.com/lexv2/latest/APIReference/API_runtime_DialogAction.html) for more information.
    dialog_action_type: ?[]const u8,

    /// The input type of the utterance. The possible values are as follows:
    ///
    /// * PCM format: audio data must be in little-endian byte order.
    ///
    /// * `audio/l16; rate=16000; channels=1`
    ///
    /// * `audio/x-l16; sample-rate=16000; channel-count=1`
    ///
    /// * `audio/lpcm; sample-rate=8000; sample-size-bits=16; channel-count=1;
    ///   is-big-endian=false`
    ///
    /// * Opus format
    ///
    /// *
    ///   `audio/x-cbr-opus-with-preamble;preamble-size=0;bit-rate=256000;frame-size-milliseconds=4`
    ///
    /// * Text format
    ///
    /// * `text/plain; charset=utf-8`
    input_type: ?[]const u8,

    /// The state of the intent that the utterance is associated to.
    intent_state: ?IntentState,

    /// The locale of the bot that the utterance was made to.
    locale_id: ?[]const u8,

    /// The mode of the session. The possible values are as follows:
    ///
    /// * `Speech` – The session consisted of spoken dialogue.
    ///
    /// * `Text` – The session consisted of written dialogue.
    ///
    /// * `DTMF` – The session consisted of touch-tone keypad (Dual Tone
    ///   Multi-Frequency) key presses.
    ///
    /// * `MultiMode` – The session consisted of multiple modes.
    mode: ?AnalyticsModality,

    /// The output type of the utterance. The possible values are as follows:
    ///
    /// * `audio/mpeg`
    ///
    /// * `audio/ogg`
    ///
    /// * `audio/pcm (16 KHz)`
    ///
    /// * `audio/` (defaults to `mpeg`)
    ///
    /// * `text/plain; charset=utf-8`
    output_type: ?[]const u8,

    /// The identifier of the session that the utterance was made in.
    session_id: ?[]const u8,

    /// The slots that have been filled in the session by the time of the utterance.
    slots_filled_in_session: ?[]const u8,

    /// The text of the utterance.
    utterance: ?[]const u8,

    /// The identifier of the request associated with the utterance.
    utterance_request_id: ?[]const u8,

    /// The date and time when the utterance took place.
    utterance_timestamp: ?i64,

    /// Specifies whether the bot understood the utterance or not.
    utterance_understood: bool = false,

    pub const json_field_names = .{
        .associated_intent_name = "associatedIntentName",
        .associated_slot_name = "associatedSlotName",
        .audio_voice_duration_millis = "audioVoiceDurationMillis",
        .bot_alias_id = "botAliasId",
        .bot_response_audio_voice_id = "botResponseAudioVoiceId",
        .bot_responses = "botResponses",
        .bot_version = "botVersion",
        .channel = "channel",
        .conversation_end_time = "conversationEndTime",
        .conversation_start_time = "conversationStartTime",
        .dialog_action_type = "dialogActionType",
        .input_type = "inputType",
        .intent_state = "intentState",
        .locale_id = "localeId",
        .mode = "mode",
        .output_type = "outputType",
        .session_id = "sessionId",
        .slots_filled_in_session = "slotsFilledInSession",
        .utterance = "utterance",
        .utterance_request_id = "utteranceRequestId",
        .utterance_timestamp = "utteranceTimestamp",
        .utterance_understood = "utteranceUnderstood",
    };
};
