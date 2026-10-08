/// Token usage information
pub const SendMessageUsageInfo = struct {
    /// Number of input tokens
    input_tokens: ?i32 = null,

    /// Number of output tokens
    output_tokens: ?i32 = null,

    /// Total tokens used
    total_tokens: ?i32 = null,

    pub const json_field_names = .{
        .input_tokens = "inputTokens",
        .output_tokens = "outputTokens",
        .total_tokens = "totalTokens",
    };
};
