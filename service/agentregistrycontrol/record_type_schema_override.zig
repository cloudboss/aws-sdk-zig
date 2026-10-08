const RecordType = @import("record_type.zig").RecordType;

/// A schema override for a specific record type within a custom metadata schema
/// configuration.
pub const RecordTypeSchemaOverride = struct {
    /// The record type that this schema override applies to.
    record_type: RecordType,

    /// The JSON Schema for the specified record type. Must follow the same
    /// structural rules as the default schema.
    schema: []const u8,

    pub const json_field_names = .{
        .record_type = "recordType",
        .schema = "schema",
    };
};
