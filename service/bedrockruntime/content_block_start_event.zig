const ContentBlockStart = @import("content_block_start.zig").ContentBlockStart;

/// Content block start event.
pub const ContentBlockStartEvent = struct {
    /// The index for a content block start event.
    content_block_index: i32,

    /// Start information about a content block start event.
    start: ContentBlockStart,

    pub const json_field_names = .{
        .content_block_index = "contentBlockIndex",
        .start = "start",
    };
};
