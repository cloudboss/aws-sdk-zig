const Participant = @import("participant.zig").Participant;
const SpanMessageValue = @import("span_message_value.zig").SpanMessageValue;

/// A message in the conversation history with participant role and content
/// values
pub const SpanMessage = struct {
    /// Unique message identifier
    message_id: []const u8,

    /// Message source role
    participant: Participant,

    /// Message timestamp
    timestamp: i64,

    /// Message content values (text, tool use, tool result)
    values: []const SpanMessageValue,

    pub const json_field_names = .{
        .message_id = "messageId",
        .participant = "participant",
        .timestamp = "timestamp",
        .values = "values",
    };
};
