const aws = @import("aws");

/// Configuration for the Amazon Bedrock foundation model used for reranking
/// vector search results. This specifies which model to use and any additional
/// parameters required by the model.
pub const VectorSearchBedrockRerankingModelConfiguration = struct {
    /// A list of additional fields to include in the model request during
    /// reranking. These fields provide extra context or configuration options
    /// specific to the selected foundation model.
    additional_model_request_fields: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon Resource Name (ARN) of the foundation model to use for reranking.
    /// This model processes the query and search results to determine a more
    /// relevant ordering.
    model_arn: []const u8,

    pub const json_field_names = .{
        .additional_model_request_fields = "additionalModelRequestFields",
        .model_arn = "modelArn",
    };
};
