const RedisEnterpriseCloudFieldMapping = @import("redis_enterprise_cloud_field_mapping.zig").RedisEnterpriseCloudFieldMapping;

/// Contains details about the storage configuration of the knowledge base in
/// Redis Enterprise Cloud. For more information, see [Create a vector index in
/// Redis Enterprise
/// Cloud](https://docs.aws.amazon.com/bedrock/latest/userguide/knowledge-base-setup-oss.html).
pub const RedisEnterpriseCloudConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the secret that you created in Secrets
    /// Manager that is linked to your Redis Enterprise Cloud database.
    credentials_secret_arn: []const u8,

    /// The endpoint URL of the Redis Enterprise Cloud database.
    endpoint: []const u8,

    /// Contains the names of the fields to which to map information about the
    /// vector store.
    field_mapping: RedisEnterpriseCloudFieldMapping,

    /// The name of the vector index.
    vector_index_name: []const u8,

    pub const json_field_names = .{
        .credentials_secret_arn = "credentialsSecretArn",
        .endpoint = "endpoint",
        .field_mapping = "fieldMapping",
        .vector_index_name = "vectorIndexName",
    };
};
