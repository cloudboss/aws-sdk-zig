const Message = @import("message.zig").Message;
const SystemContentBlock = @import("system_content_block.zig").SystemContentBlock;
const ToolConfiguration = @import("tool_configuration.zig").ToolConfiguration;

/// The inputs from a `Converse` API request for token counting.
///
/// This structure mirrors the input format for the `Converse` operation,
/// allowing you to count tokens for conversation-based inference requests.
pub const ConverseTokensRequest = struct {
    /// The additionalModelRequestFields of Converse input request to count tokens
    /// for. Use this field when you want to pass additional parameters that the
    /// model supports.
    additional_model_request_fields: ?[]const u8 = null,

    /// An array of messages to count tokens for.
    messages: ?[]const Message = null,

    /// The system content blocks to count tokens for. System content provides
    /// instructions or context to the model about how it should behave or respond.
    /// The token count will include any system content provided.
    system: ?[]const SystemContentBlock = null,

    /// The toolConfig of Converse input request to count tokens for. Configuration
    /// information for the tools that the model can use when generating a response.
    tool_config: ?ToolConfiguration = null,

    pub const json_field_names = .{
        .additional_model_request_fields = "additionalModelRequestFields",
        .messages = "messages",
        .system = "system",
        .tool_config = "toolConfig",
    };
};
