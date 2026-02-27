const ContentBlockDelta = @import("content_block_delta.zig").ContentBlockDelta;

/// The content block delta event.
pub const ContentBlockDeltaEvent = struct {
    /// The block index for a content block delta event.
    content_block_index: i32,

    /// The delta for a content block delta event.
    delta: ContentBlockDelta,

    pub const json_field_names = .{
        .content_block_index = "contentBlockIndex",
        .delta = "delta",
    };
};
