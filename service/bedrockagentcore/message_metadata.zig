/// Metadata information associated with this message.
pub const MessageMetadata = struct {
    /// The identifier of the event associated with this message.
    event_id: []const u8,

    /// The position of this message within that event’s ordered list of messages.
    message_index: i32,

    pub const json_field_names = .{
        .event_id = "eventId",
        .message_index = "messageIndex",
    };
};
