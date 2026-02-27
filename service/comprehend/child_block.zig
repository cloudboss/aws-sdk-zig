/// Nested block contained within a block.
pub const ChildBlock = struct {
    /// Offset of the start of the child block within its parent block.
    begin_offset: ?i32,

    /// Unique identifier for the child block.
    child_block_id: ?[]const u8,

    /// Offset of the end of the child block within its parent block.
    end_offset: ?i32,

    pub const json_field_names = .{
        .begin_offset = "BeginOffset",
        .child_block_id = "ChildBlockId",
        .end_offset = "EndOffset",
    };
};
