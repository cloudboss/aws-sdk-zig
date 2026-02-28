const AttributeType = @import("attribute_type.zig").AttributeType;

/// Defines the schema for a metadata attribute used in Knowledge Base vector
/// searches. Metadata attributes provide additional context for documents and
/// can be used for filtering and reranking search results.
pub const MetadataAttributeSchema = struct {
    /// An optional description of the metadata attribute that provides additional
    /// context about its purpose and usage.
    description: []const u8,

    /// The unique identifier for the metadata attribute. This key is used to
    /// reference the attribute in filter expressions and reranking configurations.
    key: []const u8,

    /// The data type of the metadata attribute. The type determines how the
    /// attribute can be used in filter expressions and reranking.
    @"type": AttributeType,

    pub const json_field_names = .{
        .description = "description",
        .key = "key",
        .@"type" = "type",
    };
};
