const aws = @import("aws");

const InputMode = @import("input_mode.zig").InputMode;
const Interpretation = @import("interpretation.zig").Interpretation;
const RecognizedBotMember = @import("recognized_bot_member.zig").RecognizedBotMember;
const SessionState = @import("session_state.zig").SessionState;

/// Contains the current state of the conversation between the client
/// application and Amazon Lex V2.
pub const IntentResultEvent = struct {
    /// A unique identifier of the event sent by Amazon Lex V2. The identifier is in
    /// the form `RESPONSE-N`, where N is a number starting with one
    /// and incremented for each event sent by Amazon Lex V2 in the current
    /// session.
    event_id: ?[]const u8,

    /// Indicates whether the input to the operation was text, speech, or from a
    /// touch-tone keypad.
    input_mode: ?InputMode,

    /// A list of intents that Amazon Lex V2 determined might satisfy the user's
    /// utterance.
    ///
    /// Each interpretation includes the intent, a score that indicates how
    /// confident Amazon Lex V2 is that the interpretation is the correct one, and
    /// an
    /// optional sentiment response that indicates the sentiment expressed in
    /// the utterance.
    interpretations: ?[]const Interpretation,

    /// The bot member that is processing the intent.
    recognized_bot_member: ?RecognizedBotMember,

    /// The attributes sent in the request.
    request_attributes: ?[]const aws.map.StringMapEntry,

    /// The identifier of the session in use.
    session_id: ?[]const u8,

    session_state: ?SessionState,

    pub const json_field_names = .{
        .event_id = "eventId",
        .input_mode = "inputMode",
        .interpretations = "interpretations",
        .recognized_bot_member = "recognizedBotMember",
        .request_attributes = "requestAttributes",
        .session_id = "sessionId",
        .session_state = "sessionState",
    };
};
