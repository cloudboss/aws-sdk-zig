const CountTokensInput = @import("count_tokens_input.zig").CountTokensInput;

pub const CountTokensRequest = struct {
    /// The input for which to count tokens. The structure of this parameter depends
    /// on whether you're counting tokens for an `InvokeModel` or `Converse`
    /// request:
    ///
    /// * For `InvokeModel` requests, provide the request body in the `invokeModel`
    ///   field
    /// * For `Converse` requests, provide the messages and system content in the
    ///   `converse` field
    ///
    /// The input format must be compatible with the model specified in the
    /// `modelId` parameter.
    input: CountTokensInput,

    /// The unique identifier or ARN of the foundation model to use for token
    /// counting. Each model processes tokens differently, so the token count is
    /// specific to the model you specify.
    model_id: []const u8,

    pub const json_field_names = .{
        .input = "input",
        .model_id = "modelId",
    };
};
