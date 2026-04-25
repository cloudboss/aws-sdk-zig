const HarnessContentBlockStart = @import("harness_content_block_start.zig").HarnessContentBlockStart;

/// Event indicating the start of a content block.
pub const HarnessContentBlockStartEvent = struct {
    /// The index of the content block within the message.
    content_block_index: i32,

    /// The content block start payload.
    start: HarnessContentBlockStart,

    pub const json_field_names = .{
        .content_block_index = "contentBlockIndex",
        .start = "start",
    };
};
