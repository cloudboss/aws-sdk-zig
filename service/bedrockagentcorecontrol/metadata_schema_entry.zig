const ExtractionConfig = @import("extraction_config.zig").ExtractionConfig;
const MetadataValueType = @import("metadata_value_type.zig").MetadataValueType;

/// A metadata field definition within a strategy's schema.
pub const MetadataSchemaEntry = struct {
    /// Configuration for extracting this metadata value from conversational
    /// content.
    extraction_config: ?ExtractionConfig = null,

    /// The metadata field name. Must match an indexed key to be queryable via
    /// metadata filters.
    key: []const u8,

    /// The MetadataValueType.
    @"type": ?MetadataValueType = null,

    pub const json_field_names = .{
        .extraction_config = "extractionConfig",
        .key = "key",
        .@"type" = "type",
    };
};
