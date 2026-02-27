const InvokeModelWithBidirectionalStreamInput = @import("invoke_model_with_bidirectional_stream_input.zig").InvokeModelWithBidirectionalStreamInput;

pub const InvokeModelWithBidirectionalStreamRequest = struct {
    /// The prompt and inference parameters in the format specified in the
    /// `BidirectionalInputPayloadPart` in the header. You must provide the body in
    /// JSON format. To see the format and content of the request and response
    /// bodies for different models, refer to [Inference
    /// parameters](https://docs.aws.amazon.com/bedrock/latest/userguide/model-parameters.html). For more information, see [Run inference](https://docs.aws.amazon.com/bedrock/latest/userguide/api-methods-run.html) in the Bedrock User Guide.
    body: InvokeModelWithBidirectionalStreamInput,

    /// The model ID or ARN of the model ID to use. Currently, only
    /// `amazon.nova-sonic-v1:0` is supported.
    model_id: []const u8,

    pub const json_field_names = .{
        .body = "body",
        .model_id = "modelId",
    };
};
