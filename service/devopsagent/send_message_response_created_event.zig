/// Event emitted when the response is created
pub const SendMessageResponseCreatedEvent = struct {
    /// The response ID
    response_id: ?[]const u8 = null,

    /// Event sequence number
    sequence_number: ?i32 = null,

    pub const json_field_names = .{
        .response_id = "responseId",
        .sequence_number = "sequenceNumber",
    };
};
