const aws = @import("aws");

/// Model configuration for a Bedrock reranking model used in managed search.
pub const ManagedSearchBedrockRerankingModelConfiguration = struct {
    /// Additional request fields to pass to the reranking model.
    additional_model_request_fields: ?[]const aws.map.StringMapEntry = null,

    /// The ARN of the Bedrock reranking model.
    model_arn: []const u8,

    pub const json_field_names = .{
        .additional_model_request_fields = "additionalModelRequestFields",
        .model_arn = "modelArn",
    };
};
