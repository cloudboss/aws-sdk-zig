const OpenSearchManagedClusterFieldMapping = @import("open_search_managed_cluster_field_mapping.zig").OpenSearchManagedClusterFieldMapping;

/// Contains details about the Managed Cluster configuration of the knowledge
/// base in Amazon OpenSearch Service. For more information, see [Create a
/// vector index in OpenSearch Managed
/// Cluster](https://docs.aws.amazon.com/bedrock/latest/userguide/knowledge-base-setup-osm.html).
pub const OpenSearchManagedClusterConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the OpenSearch domain.
    domain_arn: []const u8,

    /// The endpoint URL the OpenSearch domain.
    domain_endpoint: []const u8,

    /// Contains the names of the fields to which to map information about the
    /// vector store.
    field_mapping: OpenSearchManagedClusterFieldMapping,

    /// The name of the vector store.
    vector_index_name: []const u8,

    pub const json_field_names = .{
        .domain_arn = "domainArn",
        .domain_endpoint = "domainEndpoint",
        .field_mapping = "fieldMapping",
        .vector_index_name = "vectorIndexName",
    };
};
