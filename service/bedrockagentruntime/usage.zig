/// Contains information of the usage of the foundation model.
pub const Usage = struct {
    /// Contains information about the input tokens from the foundation model usage.
    input_tokens: ?i32 = null,

    /// Contains information about the output tokens from the foundation model
    /// usage.
    output_tokens: ?i32 = null,

    pub const json_field_names = .{
        .input_tokens = "inputTokens",
        .output_tokens = "outputTokens",
    };
};
