const PineconeFieldMapping = @import("pinecone_field_mapping.zig").PineconeFieldMapping;

/// Contains details about the storage configuration of the knowledge base in
/// Pinecone. For more information, see [Create a vector index in
/// Pinecone](https://docs.aws.amazon.com/bedrock/latest/userguide/knowledge-base-setup-pinecone.html).
pub const PineconeConfiguration = struct {
    /// The endpoint URL for your index management page.
    connection_string: []const u8,

    /// The Amazon Resource Name (ARN) of the secret that you created in Secrets
    /// Manager that is linked to your Pinecone API key.
    credentials_secret_arn: []const u8,

    /// Contains the names of the fields to which to map information about the
    /// vector store.
    field_mapping: PineconeFieldMapping,

    /// The namespace to be used to write new data to your database.
    namespace: ?[]const u8 = null,

    pub const json_field_names = .{
        .connection_string = "connectionString",
        .credentials_secret_arn = "credentialsSecretArn",
        .field_mapping = "fieldMapping",
        .namespace = "namespace",
    };
};
