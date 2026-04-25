/// Event indicating the end of a content block.
pub const HarnessContentBlockStopEvent = struct {
    /// The index of the content block that ended.
    content_block_index: i32,

    pub const json_field_names = .{
        .content_block_index = "contentBlockIndex",
    };
};
