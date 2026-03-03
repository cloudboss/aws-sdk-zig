const MessageProcessingStatus = @import("message_processing_status.zig").MessageProcessingStatus;

/// Contains metadata for chat messages.
pub const MessageProcessingMetadata = struct {
    /// The status of Message Processing for the message.
    message_processing_status: ?MessageProcessingStatus = null,

    pub const json_field_names = .{
        .message_processing_status = "MessageProcessingStatus",
    };
};
