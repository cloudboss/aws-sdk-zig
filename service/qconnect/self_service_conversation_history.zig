/// The conversation history data to included in conversation context data
/// before the Amazon Q in Connect session.
pub const SelfServiceConversationHistory = struct {
    /// The bot response of the conversation history data.
    bot_response: ?[]const u8,

    /// The input transcript of the conversation history data.
    input_transcript: ?[]const u8,

    /// The timestamp of the conversation history entry.
    timestamp: ?i64,

    /// The number of turn of the conversation history data.
    turn_number: i32 = 0,

    pub const json_field_names = .{
        .bot_response = "botResponse",
        .input_transcript = "inputTranscript",
        .timestamp = "timestamp",
        .turn_number = "turnNumber",
    };
};
