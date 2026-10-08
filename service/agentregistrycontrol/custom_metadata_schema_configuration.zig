const RecordTypeSchemaOverride = @import("record_type_schema_override.zig").RecordTypeSchemaOverride;

/// Configuration that defines a typed metadata schema for a registry. Specify
/// at least one of a default schema or per-record-type schema overrides. You
/// can provide both.
pub const CustomMetadataSchemaConfiguration = struct {
    /// The default JSON Schema that applies to record types without a specific
    /// override. Supported property types are `string`, `string` with an `enum`
    /// constraint, `string` with a `uri` format, and `boolean`.
    default_schema: ?[]const u8 = null,

    /// A list of per-record-type schema overrides. When a record's type matches an
    /// override, that override's schema is used instead of the default schema for
    /// validation. If you don't specify an override for a record type, the default
    /// schema applies. If no default schema exists, custom metadata on records of
    /// that type is rejected.
    record_type_schema_overrides: ?[]const RecordTypeSchemaOverride = null,

    pub const json_field_names = .{
        .default_schema = "defaultSchema",
        .record_type_schema_overrides = "recordTypeSchemaOverrides",
    };
};
