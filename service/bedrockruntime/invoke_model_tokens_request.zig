/// The body of an `InvokeModel` API request for token counting. This structure
/// mirrors the input format for the `InvokeModel` operation, allowing you to
/// count tokens for raw text inference requests.
pub const InvokeModelTokensRequest = struct {
    /// The request body to count tokens for, formatted according to the model's
    /// expected input format. To learn about the input format for different models,
    /// see [Model inference parameters and
    /// responses](https://docs.aws.amazon.com/bedrock/latest/userguide/model-parameters.html).
    body: []const u8,

    pub const json_field_names = .{
        .body = "body",
    };
};
