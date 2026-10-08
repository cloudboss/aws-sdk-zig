/// Event emitted when the response fails
pub const SendMessageResponseFailedEvent = struct {
    /// Error code
    error_code: ?[]const u8 = null,

    /// Error message
    error_message: ?[]const u8 = null,

    /// The response ID
    response_id: ?[]const u8 = null,

    /// Event sequence number
    sequence_number: ?i32 = null,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .response_id = "responseId",
        .sequence_number = "sequenceNumber",
    };
};
