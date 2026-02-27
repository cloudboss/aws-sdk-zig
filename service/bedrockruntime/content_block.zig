const AudioBlock = @import("audio_block.zig").AudioBlock;
const CachePointBlock = @import("cache_point_block.zig").CachePointBlock;
const CitationsContentBlock = @import("citations_content_block.zig").CitationsContentBlock;
const DocumentBlock = @import("document_block.zig").DocumentBlock;
const GuardrailConverseContentBlock = @import("guardrail_converse_content_block.zig").GuardrailConverseContentBlock;
const ImageBlock = @import("image_block.zig").ImageBlock;
const ReasoningContentBlock = @import("reasoning_content_block.zig").ReasoningContentBlock;
const SearchResultBlock = @import("search_result_block.zig").SearchResultBlock;
const ToolResultBlock = @import("tool_result_block.zig").ToolResultBlock;
const ToolUseBlock = @import("tool_use_block.zig").ToolUseBlock;
const VideoBlock = @import("video_block.zig").VideoBlock;

/// A block of content for a message that you pass to, or receive from, a model
/// with the
/// [Converse](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_runtime_Converse.html) or [ConverseStream](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_runtime_ConverseStream.html) API operations.
pub const ContentBlock = union(enum) {
    /// An audio content block containing audio data in the conversation.
    audio: ?AudioBlock,
    /// CachePoint to include in the message.
    cache_point: ?CachePointBlock,
    /// A content block that contains both generated text and associated citation
    /// information, providing traceability between the response and source
    /// documents.
    citations_content: ?CitationsContentBlock,
    /// A document to include in the message.
    document: ?DocumentBlock,
    /// Contains the content to assess with the guardrail. If you don't specify
    /// `guardContent` in a call to the Converse API, the guardrail (if passed in
    /// the Converse API) assesses the entire message.
    ///
    /// For more information, see *Use a guardrail with the Converse API* in the
    /// *Amazon Bedrock User Guide*.
    guard_content: ?GuardrailConverseContentBlock,
    /// Image to include in the message.
    ///
    /// This field is only supported by Anthropic Claude 3 models.
    image: ?ImageBlock,
    /// Contains content regarding the reasoning that is carried out by the model.
    /// Reasoning refers to a Chain of Thought (CoT) that the model generates to
    /// enhance the accuracy of its final response.
    reasoning_content: ?ReasoningContentBlock,
    /// Search result to include in the message.
    search_result: ?SearchResultBlock,
    /// Text to include in the message.
    text: ?[]const u8,
    /// The result for a tool request that a model makes.
    tool_result: ?ToolResultBlock,
    /// Information about a tool use request from a model.
    tool_use: ?ToolUseBlock,
    /// Video to include in the message.
    video: ?VideoBlock,

    pub const json_field_names = .{
        .audio = "audio",
        .cache_point = "cachePoint",
        .citations_content = "citationsContent",
        .document = "document",
        .guard_content = "guardContent",
        .image = "image",
        .reasoning_content = "reasoningContent",
        .search_result = "searchResult",
        .text = "text",
        .tool_result = "toolResult",
        .tool_use = "toolUse",
        .video = "video",
    };
};
