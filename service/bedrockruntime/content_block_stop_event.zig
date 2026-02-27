/// A content block stop event.
pub const ContentBlockStopEvent = struct {
    /// The index for a content block.
    content_block_index: i32,

    pub const json_field_names = .{
        .content_block_index = "contentBlockIndex",
    };
};
