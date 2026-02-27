/// Information about the overall participant interactions at the contact level.
pub const ChatContactMetrics = struct {
    /// The time for an agent to respond after obtaining a chat contact.
    agent_first_response_time_in_millis: ?i64,

    /// The agent first response timestamp for a chat contact.
    agent_first_response_timestamp: ?i64,

    /// The time it took for a contact to end after the last customer message.
    conversation_close_time_in_millis: ?i64,

    /// The number of conversation turns in a chat contact, which represents the
    /// back-and-forth exchanges between
    /// customer and other participants.
    conversation_turn_count: ?i32,

    /// A boolean flag indicating whether multiparty chat or supervisor barge were
    /// enabled on this contact.
    multi_party: ?bool,

    /// The total number of characters from bot and automated messages on a chat
    /// contact.
    total_bot_message_length_in_chars: ?i32,

    /// The total number of bot and automated messages on a chat contact.
    total_bot_messages: ?i32,

    /// The number of chat messages on the contact.
    total_messages: ?i32,

    pub const json_field_names = .{
        .agent_first_response_time_in_millis = "AgentFirstResponseTimeInMillis",
        .agent_first_response_timestamp = "AgentFirstResponseTimestamp",
        .conversation_close_time_in_millis = "ConversationCloseTimeInMillis",
        .conversation_turn_count = "ConversationTurnCount",
        .multi_party = "MultiParty",
        .total_bot_message_length_in_chars = "TotalBotMessageLengthInChars",
        .total_bot_messages = "TotalBotMessages",
        .total_messages = "TotalMessages",
    };
};
