/// Event emitted when a content block is complete
pub const SendMessageContentBlockStopEvent = struct {
    /// Zero-based index of the content block
    index: ?i32 = null,

    /// Whether this is the final content block in the response
    last: ?bool = null,

    /// Event sequence number
    sequence_number: ?i32 = null,

    /// The accumulated complete content text
    text: ?[]const u8 = null,

    /// The type of content in this block
    type: ?[]const u8 = null,

    pub const json_field_names = .{
        .index = "index",
        .last = "last",
        .sequence_number = "sequenceNumber",
        .text = "text",
        .type = "type",
    };
};
