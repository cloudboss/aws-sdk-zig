const ImageBlockStart = @import("image_block_start.zig").ImageBlockStart;
const ToolResultBlockStart = @import("tool_result_block_start.zig").ToolResultBlockStart;
const ToolUseBlockStart = @import("tool_use_block_start.zig").ToolUseBlockStart;

/// Content block start information.
pub const ContentBlockStart = union(enum) {
    /// The initial event indicating the start of a streaming image block.
    image: ?ImageBlockStart,
    /// The
    tool_result: ?ToolResultBlockStart,
    /// Information about a tool that the model is requesting to use.
    tool_use: ?ToolUseBlockStart,

    pub const json_field_names = .{
        .image = "image",
        .tool_result = "toolResult",
        .tool_use = "toolUse",
    };
};
