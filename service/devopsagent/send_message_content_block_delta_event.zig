const SendMessageContentBlockDelta = @import("send_message_content_block_delta.zig").SendMessageContentBlockDelta;

/// Event emitted for each incremental content delta within a content block
pub const SendMessageContentBlockDeltaEvent = struct {
    /// The incremental content delta
    delta: ?SendMessageContentBlockDelta = null,

    /// Zero-based index of the content block
    index: ?i32 = null,

    /// Event sequence number
    sequence_number: ?i32 = null,

    pub const json_field_names = .{
        .delta = "delta",
        .index = "index",
        .sequence_number = "sequenceNumber",
    };
};
