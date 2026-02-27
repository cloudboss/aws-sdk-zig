const CitationsDelta = @import("citations_delta.zig").CitationsDelta;
const ImageBlockDelta = @import("image_block_delta.zig").ImageBlockDelta;
const ReasoningContentBlockDelta = @import("reasoning_content_block_delta.zig").ReasoningContentBlockDelta;
const ToolResultBlockDelta = @import("tool_result_block_delta.zig").ToolResultBlockDelta;
const ToolUseBlockDelta = @import("tool_use_block_delta.zig").ToolUseBlockDelta;

/// A block of content in a streaming response.
pub const ContentBlockDelta = union(enum) {
    /// Incremental citation information that is streamed as part of the response
    /// generation process.
    citation: ?CitationsDelta,
    /// A streaming delta event containing incremental image data.
    image: ?ImageBlockDelta,
    /// Contains content regarding the reasoning that is carried out by the model.
    /// Reasoning refers to a Chain of Thought (CoT) that the model generates to
    /// enhance the accuracy of its final response.
    reasoning_content: ?ReasoningContentBlockDelta,
    /// The content text.
    text: ?[]const u8,
    /// An incremental update that contains the results from a tool call.
    tool_result: ?[]const ToolResultBlockDelta,
    /// Information about a tool that the model is requesting to use.
    tool_use: ?ToolUseBlockDelta,

    pub const json_field_names = .{
        .citation = "citation",
        .image = "image",
        .reasoning_content = "reasoningContent",
        .text = "text",
        .tool_result = "toolResult",
        .tool_use = "toolUse",
    };
};
