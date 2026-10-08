/// Event emitted when a new content block starts
pub const SendMessageContentBlockStartEvent = struct {
    /// Block identifier
    id: ?[]const u8 = null,

    /// Zero-based index of the content block
    index: ?i32 = null,

    /// Optional parent block ID for nested content blocks (e.g. subagent tool
    /// calls)
    parent_id: ?[]const u8 = null,

    /// Event sequence number
    sequence_number: ?i32 = null,

    /// The type of content in this block
    type: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "id",
        .index = "index",
        .parent_id = "parentId",
        .sequence_number = "sequenceNumber",
        .type = "type",
    };
};
