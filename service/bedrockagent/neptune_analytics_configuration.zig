const NeptuneAnalyticsFieldMapping = @import("neptune_analytics_field_mapping.zig").NeptuneAnalyticsFieldMapping;

/// Contains details about the storage configuration of the knowledge base in
/// Amazon Neptune Analytics. For more information, see [Create a vector index
/// in Amazon Neptune
/// Analytics](https://docs.aws.amazon.com/bedrock/latest/userguide/knowledge-base-setup-neptune.html).
pub const NeptuneAnalyticsConfiguration = struct {
    /// Contains the names of the fields to which to map information about the
    /// vector store.
    field_mapping: NeptuneAnalyticsFieldMapping,

    /// The Amazon Resource Name (ARN) of the Neptune Analytics vector store.
    graph_arn: []const u8,

    pub const json_field_names = .{
        .field_mapping = "fieldMapping",
        .graph_arn = "graphArn",
    };
};
