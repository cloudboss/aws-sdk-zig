const ConverseTokensRequest = @import("converse_tokens_request.zig").ConverseTokensRequest;
const InvokeModelTokensRequest = @import("invoke_model_tokens_request.zig").InvokeModelTokensRequest;

/// The input value for token counting. The value should be either an
/// `InvokeModel` or `Converse` request body.
pub const CountTokensInput = union(enum) {
    /// A `Converse` request for which to count tokens. Use this field when you want
    /// to count tokens for a conversation-based input that would be sent to the
    /// `Converse` operation.
    converse: ?ConverseTokensRequest,
    /// An `InvokeModel` request for which to count tokens. Use this field when you
    /// want to count tokens for a raw text input that would be sent to the
    /// `InvokeModel` operation.
    invoke_model: ?InvokeModelTokensRequest,

    pub const json_field_names = .{
        .converse = "converse",
        .invoke_model = "invokeModel",
    };
};
