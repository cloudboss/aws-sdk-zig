const RecordType = @import("record_type.zig").RecordType;

/// The custom metadata fields for one record type, in addition to the common
/// attributes defined in `defaultSchema`.
pub const RecordTypeSchemaOverride = struct {
    /// The record type these fields apply to.
    record_type: RecordType,

    /// A JSON Schema with the fields for this record type.
    schema: []const u8,

    pub const json_field_names = .{
        .record_type = "recordType",
        .schema = "schema",
    };
};
