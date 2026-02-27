const Participant = @import("participant.zig").Participant;
const MessageData = @import("message_data.zig").MessageData;

/// The message output.
pub const MessageOutput = struct {
    /// The identifier of a message.
    message_id: []const u8,

    /// The participant of a message.
    participant: Participant,

    /// The timestamp of a message.
    timestamp: i64,

    /// The value of a message data.
    value: MessageData,

    pub const json_field_names = .{
        .message_id = "messageId",
        .participant = "participant",
        .timestamp = "timestamp",
        .value = "value",
    };
};
