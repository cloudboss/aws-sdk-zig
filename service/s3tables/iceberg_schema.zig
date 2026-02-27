const SchemaField = @import("schema_field.zig").SchemaField;

/// Contains details about the schema for an Iceberg table.
pub const IcebergSchema = struct {
    /// The schema fields for the table
    fields: []const SchemaField,

    pub const json_field_names = .{
        .fields = "fields",
    };
};
