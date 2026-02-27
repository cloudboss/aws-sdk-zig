const MetadataAttributeSchema = @import("metadata_attribute_schema.zig").MetadataAttributeSchema;

/// Configuration for implicit filtering in Knowledge Base vector searches.
/// Implicit filtering allows you to automatically filter search results based
/// on metadata attributes without requiring explicit filter expressions in each
/// query.
pub const ImplicitFilterConfiguration = struct {
    /// A list of metadata attribute schemas that define the structure and
    /// properties of metadata fields used for implicit filtering. Each attribute
    /// defines a key, type, and optional description.
    metadata_attributes: []const MetadataAttributeSchema,

    /// The Amazon Resource Name (ARN) of the foundation model used for implicit
    /// filtering. This model processes the query to extract relevant filtering
    /// criteria.
    model_arn: []const u8,

    pub const json_field_names = .{
        .metadata_attributes = "metadataAttributes",
        .model_arn = "modelArn",
    };
};
