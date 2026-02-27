const aws = @import("aws");

/// Contains configurations for an Amazon Bedrock reranker model.
pub const VectorSearchBedrockRerankingModelConfiguration = struct {
    /// A JSON object whose keys are request fields for the model and whose values
    /// are values for those fields.
    additional_model_request_fields: ?[]const aws.map.StringMapEntry,

    /// The ARN of the reranker model to use.
    model_arn: []const u8,

    pub const json_field_names = .{
        .additional_model_request_fields = "additionalModelRequestFields",
        .model_arn = "modelArn",
    };
};
