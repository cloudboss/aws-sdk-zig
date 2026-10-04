const EmbeddingModelConfiguration = @import("embedding_model_configuration.zig").EmbeddingModelConfiguration;
const EmbeddingModelType = @import("embedding_model_type.zig").EmbeddingModelType;
const ServerSideEncryptionConfiguration = @import("server_side_encryption_configuration.zig").ServerSideEncryptionConfiguration;
const SupplementalDataStorageConfiguration = @import("supplemental_data_storage_configuration.zig").SupplementalDataStorageConfiguration;

/// Configurations for a managed knowledge base.
pub const ManagedKnowledgeBaseConfiguration = struct {
    /// The ARN for the embeddings model.
    embedding_model_arn: ?[]const u8 = null,

    /// The configuration details for the embeddings model. Not required when
    /// choosing the MANAGED embeddingModelType.
    embedding_model_configuration: ?EmbeddingModelConfiguration = null,

    /// Choose CUSTOM to provide your own Bedrock embedding model ARN. Choose
    /// MANAGED to use a service-managed embedding model.
    embedding_model_type: ?EmbeddingModelType = null,

    /// Contains the configuration for server-side encryption for your managed
    /// knowledge base.
    server_side_encryption_configuration: ?ServerSideEncryptionConfiguration = null,

    /// Use this object to specify the Amazon S3 location that the knowledge base
    /// uses to process and ingest multimodal content. This field is required when
    /// you use a native multimodal embedding model.
    supplemental_data_storage_configuration: ?SupplementalDataStorageConfiguration = null,

    pub const json_field_names = .{
        .embedding_model_arn = "embeddingModelArn",
        .embedding_model_configuration = "embeddingModelConfiguration",
        .embedding_model_type = "embeddingModelType",
        .server_side_encryption_configuration = "serverSideEncryptionConfiguration",
        .supplemental_data_storage_configuration = "supplementalDataStorageConfiguration",
    };
};
