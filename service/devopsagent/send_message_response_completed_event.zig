const SendMessageUsageInfo = @import("send_message_usage_info.zig").SendMessageUsageInfo;

/// Event emitted when the response completes successfully
pub const SendMessageResponseCompletedEvent = struct {
    /// The response ID
    response_id: ?[]const u8 = null,

    /// Event sequence number
    sequence_number: ?i32 = null,

    /// Token usage information
    usage: ?SendMessageUsageInfo = null,

    pub const json_field_names = .{
        .response_id = "responseId",
        .sequence_number = "sequenceNumber",
        .usage = "usage",
    };
};
