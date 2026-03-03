const TimestampValue = @import("timestamp_value.zig").TimestampValue;

/// Information about a message.
pub const Message = struct {
    /// The name of the input into which the message payload is transformed.
    input_name: []const u8,

    /// The ID to assign to the message. Within each batch sent, each `"messageId"`
    /// must be unique.
    message_id: []const u8,

    /// The payload of the message. This can be a JSON string or a Base-64-encoded
    /// string
    /// representing binary data (in which case you must decode it).
    payload: []const u8,

    /// The timestamp associated with the message.
    timestamp: ?TimestampValue = null,

    pub const json_field_names = .{
        .input_name = "inputName",
        .message_id = "messageId",
        .payload = "payload",
        .timestamp = "timestamp",
    };
};
