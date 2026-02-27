const CachePointBlock = @import("cache_point_block.zig").CachePointBlock;
const GuardrailConverseContentBlock = @import("guardrail_converse_content_block.zig").GuardrailConverseContentBlock;

/// Contains configurations for instructions to provide the model for how to
/// handle input. To learn more, see [Using the Converse
/// API](https://docs.aws.amazon.com/bedrock/latest/userguide/conversation-inference-call.html).
pub const SystemContentBlock = union(enum) {
    /// CachePoint to include in the system prompt.
    cache_point: ?CachePointBlock,
    /// A content block to assess with the guardrail. Use with the
    /// [Converse](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_runtime_Converse.html) or [ConverseStream](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_runtime_ConverseStream.html) API operations.
    ///
    /// For more information, see *Use a guardrail with the Converse API* in the
    /// *Amazon Bedrock User Guide*.
    guard_content: ?GuardrailConverseContentBlock,
    /// A system prompt for the model.
    text: ?[]const u8,

    pub const json_field_names = .{
        .cache_point = "cachePoint",
        .guard_content = "guardContent",
        .text = "text",
    };
};
