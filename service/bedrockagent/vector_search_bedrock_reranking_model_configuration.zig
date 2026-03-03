const aws = @import("aws");

/// Configures the Amazon Bedrock model used for reranking retrieved results.
pub const VectorSearchBedrockRerankingModelConfiguration = struct {
    /// Specifies additional model-specific request parameters as key-value pairs
    /// that are included in the request to the Amazon Bedrock reranker model.
    additional_model_request_fields: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon Resource Name (ARN) of the Amazon Bedrock reranker model.
    model_arn: []const u8,

    pub const json_field_names = .{
        .additional_model_request_fields = "additionalModelRequestFields",
        .model_arn = "modelArn",
    };
};
