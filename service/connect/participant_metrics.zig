const ParticipantType = @import("participant_type.zig").ParticipantType;

/// Information about a participant's interactions in a contact.
pub const ParticipantMetrics = struct {
    /// A boolean flag indicating whether the chat conversation was abandoned by a
    /// Participant.
    conversation_abandon: ?bool,

    /// Timestamp of last chat message by Participant.
    last_message_timestamp: ?i64,

    /// Maximum chat response time by Participant.
    max_response_time_in_millis: ?i64,

    /// Number of chat characters sent by Participant.
    message_length_in_chars: ?i32,

    /// Number of chat messages sent by Participant.
    messages_sent: ?i32,

    /// Number of chat messages sent by Participant.
    num_responses: ?i32,

    /// The Participant's ID.
    participant_id: ?[]const u8,

    /// Information about the conversation participant. Following are the
    /// participant types: [Agent, Customer,
    /// Supervisor].
    participant_type: ?ParticipantType,

    /// Total chat response time by Participant.
    total_response_time_in_millis: ?i64,

    pub const json_field_names = .{
        .conversation_abandon = "ConversationAbandon",
        .last_message_timestamp = "LastMessageTimestamp",
        .max_response_time_in_millis = "MaxResponseTimeInMillis",
        .message_length_in_chars = "MessageLengthInChars",
        .messages_sent = "MessagesSent",
        .num_responses = "NumResponses",
        .participant_id = "ParticipantId",
        .participant_type = "ParticipantType",
        .total_response_time_in_millis = "TotalResponseTimeInMillis",
    };
};
