const ExtractionConfig = @import("extraction_config.zig").ExtractionConfig;
const ExtractionType = @import("extraction_type.zig").ExtractionType;
const MetadataValueType = @import("metadata_value_type.zig").MetadataValueType;

/// A metadata field definition within a strategy's schema.
pub const MetadataSchemaEntry = struct {
    /// Configuration for extracting this metadata value from conversational
    /// content. Applicable only if extractionType is LLM inferred.
    extraction_config: ?ExtractionConfig = null,

    /// Specifies whether the metadata value is extracted by the LLM or passed
    /// through deterministically from the event.
    extraction_type: ?ExtractionType = null,

    /// The metadata field name. Must match an indexed key to be queryable via
    /// metadata filters.
    key: []const u8,

    /// The MetadataValueType.
    type: ?MetadataValueType = null,

    pub const json_field_names = .{
        .extraction_config = "extractionConfig",
        .extraction_type = "extractionType",
        .key = "key",
        .type = "type",
    };
};
