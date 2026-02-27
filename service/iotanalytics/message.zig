/// Information about a message.
pub const Message = struct {
    /// The ID you want to assign to the message. Each `messageId` must be unique
    /// within each batch sent.
    message_id: []const u8,

    /// The payload of the message. This can be a JSON string or a base64-encoded
    /// string
    /// representing binary data, in which case you must decode it by means of a
    /// pipeline
    /// activity.
    payload: []const u8,

    pub const json_field_names = .{
        .message_id = "messageId",
        .payload = "payload",
    };
};
