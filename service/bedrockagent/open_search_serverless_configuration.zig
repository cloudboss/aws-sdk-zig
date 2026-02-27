const OpenSearchServerlessFieldMapping = @import("open_search_serverless_field_mapping.zig").OpenSearchServerlessFieldMapping;

/// Contains details about the storage configuration of the knowledge base in
/// Amazon OpenSearch Service. For more information, see [Create a vector index
/// in Amazon OpenSearch
/// Service](https://docs.aws.amazon.com/bedrock/latest/userguide/knowledge-base-setup-oss.html).
pub const OpenSearchServerlessConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the OpenSearch Service vector store.
    collection_arn: []const u8,

    /// Contains the names of the fields to which to map information about the
    /// vector store.
    field_mapping: OpenSearchServerlessFieldMapping,

    /// The name of the vector store.
    vector_index_name: []const u8,

    pub const json_field_names = .{
        .collection_arn = "collectionArn",
        .field_mapping = "fieldMapping",
        .vector_index_name = "vectorIndexName",
    };
};
