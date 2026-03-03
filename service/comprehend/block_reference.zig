const ChildBlock = @import("child_block.zig").ChildBlock;

/// A reference to a block.
pub const BlockReference = struct {
    /// Offset of the start of the block within its parent block.
    begin_offset: ?i32 = null,

    /// Unique identifier for the block.
    block_id: ?[]const u8 = null,

    /// List of child blocks within this block.
    child_blocks: ?[]const ChildBlock = null,

    /// Offset of the end of the block within its parent block.
    end_offset: ?i32 = null,

    pub const json_field_names = .{
        .begin_offset = "BeginOffset",
        .block_id = "BlockId",
        .child_blocks = "ChildBlocks",
        .end_offset = "EndOffset",
    };
};
