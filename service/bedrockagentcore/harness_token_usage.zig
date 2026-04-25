/// Token usage counts for the invocation.
pub const HarnessTokenUsage = struct {
    /// The number of input tokens read from cache.
    cache_read_input_tokens: ?i32 = null,

    /// The number of input tokens written to cache.
    cache_write_input_tokens: ?i32 = null,

    /// The number of input tokens consumed.
    input_tokens: i32,

    /// The number of output tokens generated.
    output_tokens: i32,

    /// The total number of tokens consumed.
    total_tokens: i32,

    pub const json_field_names = .{
        .cache_read_input_tokens = "cacheReadInputTokens",
        .cache_write_input_tokens = "cacheWriteInputTokens",
        .input_tokens = "inputTokens",
        .output_tokens = "outputTokens",
        .total_tokens = "totalTokens",
    };
};
