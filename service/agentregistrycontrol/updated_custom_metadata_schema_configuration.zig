const CustomMetadataSchemaConfiguration = @import("custom_metadata_schema_configuration.zig").CustomMetadataSchemaConfiguration;

/// The custom metadata schema configuration patch wrapper. Omit to leave the
/// existing schema unchanged.
pub const UpdatedCustomMetadataSchemaConfiguration = struct {
    /// The value to set for this field. Omit the wrapper to leave the field
    /// unchanged.
    optional_value: ?CustomMetadataSchemaConfiguration = null,

    pub const json_field_names = .{
        .optional_value = "optionalValue",
    };
};
