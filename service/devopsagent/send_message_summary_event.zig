/// Event summarizing agent actions
pub const SendMessageSummaryEvent = struct {
    /// Summary content
    content: ?[]const u8 = null,

    /// Event sequence number
    sequence_number: ?i32 = null,

    pub const json_field_names = .{
        .content = "content",
        .sequence_number = "sequenceNumber",
    };
};
