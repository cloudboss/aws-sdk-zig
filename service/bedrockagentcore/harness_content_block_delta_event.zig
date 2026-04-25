const HarnessContentBlockDelta = @import("harness_content_block_delta.zig").HarnessContentBlockDelta;

/// Event containing a delta update to a content block.
pub const HarnessContentBlockDeltaEvent = struct {
    /// The index of the content block being updated.
    content_block_index: i32,

    /// The delta payload.
    delta: HarnessContentBlockDelta,

    pub const json_field_names = .{
        .content_block_index = "contentBlockIndex",
        .delta = "delta",
    };
};
