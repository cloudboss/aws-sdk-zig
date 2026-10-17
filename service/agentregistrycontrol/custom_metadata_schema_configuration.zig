const RecordTypeSchemaOverride = @import("record_type_schema_override.zig").RecordTypeSchemaOverride;

/// The custom metadata fields that records in the registry can carry.
/// `defaultSchema` defines the common attributes for every record type, and
/// `recordTypeSchemaOverrides` adds fields for individual record types.
pub const CustomMetadataSchemaConfiguration = struct {
    /// A JSON Schema with the common attributes: fields that records of every
    /// record type can carry.
    default_schema: ?[]const u8 = null,

    /// The fields for individual record types. Records of a record type can carry
    /// the common attributes defined in `defaultSchema` plus that record type's
    /// fields.
    record_type_schema_overrides: ?[]const RecordTypeSchemaOverride = null,

    pub const json_field_names = .{
        .default_schema = "defaultSchema",
        .record_type_schema_overrides = "recordTypeSchemaOverrides",
    };
};
