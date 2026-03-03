const BedrockEmbeddingModelConfiguration = @import("bedrock_embedding_model_configuration.zig").BedrockEmbeddingModelConfiguration;

/// The configuration details for the embeddings model.
pub const EmbeddingModelConfiguration = struct {
    /// The vector configuration details on the Bedrock embeddings model.
    bedrock_embedding_model_configuration: ?BedrockEmbeddingModelConfiguration = null,

    pub const json_field_names = .{
        .bedrock_embedding_model_configuration = "bedrockEmbeddingModelConfiguration",
    };
};
