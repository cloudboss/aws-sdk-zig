const MetadataAttributeSchema = @import("metadata_attribute_schema.zig").MetadataAttributeSchema;

/// Settings for implicit filtering, where a model generates a metadata filter
/// based on the prompt.
pub const ImplicitFilterConfiguration = struct {
    /// Metadata that can be used in a filter.
    metadata_attributes: []const MetadataAttributeSchema,

    /// The model that generates the filter.
    model_arn: []const u8,

    pub const json_field_names = .{
        .metadata_attributes = "metadataAttributes",
        .model_arn = "modelArn",
    };
};
