const EmbeddingModelConfiguration = @import("embedding_model_configuration.zig").EmbeddingModelConfiguration;
const SupplementalDataStorageConfiguration = @import("supplemental_data_storage_configuration.zig").SupplementalDataStorageConfiguration;

/// Contains details about the model used to create vector embeddings for the
/// knowledge base.
pub const VectorKnowledgeBaseConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the model used to create vector embeddings
    /// for the knowledge base.
    embedding_model_arn: []const u8,

    /// The embeddings model configuration details for the vector model used in
    /// Knowledge Base.
    embedding_model_configuration: ?EmbeddingModelConfiguration,

    /// If you include multimodal data from your data source, use this object to
    /// specify configurations for the storage location of the images extracted from
    /// your documents. These images can be retrieved and returned to the end user.
    /// They can also be used in generation when using
    /// [RetrieveAndGenerate](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_RetrieveAndGenerate.html).
    supplemental_data_storage_configuration: ?SupplementalDataStorageConfiguration,

    pub const json_field_names = .{
        .embedding_model_arn = "embeddingModelArn",
        .embedding_model_configuration = "embeddingModelConfiguration",
        .supplemental_data_storage_configuration = "supplementalDataStorageConfiguration",
    };
};
