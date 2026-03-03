const MessageProcessingStatus = @import("message_processing_status.zig").MessageProcessingStatus;
const Receipt = @import("receipt.zig").Receipt;

/// Contains metadata related to a message.
pub const MessageMetadata = struct {
    /// The identifier of the message that contains the metadata information.
    message_id: ?[]const u8 = null,

    /// The status of Message Processing for the message.
    message_processing_status: ?MessageProcessingStatus = null,

    /// The list of receipt information for a message for different recipients.
    receipts: ?[]const Receipt = null,

    pub const json_field_names = .{
        .message_id = "MessageId",
        .message_processing_status = "MessageProcessingStatus",
        .receipts = "Receipts",
    };
};
