/// Model configuration for a Bedrock reranking model.
pub const AgenticRetrieveBedrockRerankingModelConfiguration = struct {
    /// The ARN of the Bedrock reranking model.
    model_arn: []const u8,

    pub const json_field_names = .{
        .model_arn = "modelArn",
    };
};
