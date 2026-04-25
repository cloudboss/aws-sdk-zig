const SchemaV2Field = @import("schema_v2_field.zig").SchemaV2Field;
const SchemaV2FieldType = @import("schema_v2_field_type.zig").SchemaV2FieldType;

/// Contains details about the schema for an Iceberg table using the V2 format.
/// This schema format supports nested and complex data types such as `struct`,
/// `list`, and `map`, in addition to primitive types.
pub const IcebergSchemaV2 = struct {
    /// The schema fields for the table. Each field defines a column in the table,
    /// including its name, type, and whether it is required.
    fields: []const SchemaV2Field,

    /// A list of field IDs that are used as the identifier fields for the table.
    /// Identifier fields uniquely identify a row in the table.
    identifier_field_ids: ?[]const i32 = null,

    /// An optional unique identifier for the schema. Schema IDs are used by Apache
    /// Iceberg to track schema evolution.
    schema_id: ?i32 = null,

    /// The type of the top-level schema, which is always a `struct` type as defined
    /// in the [Apache Iceberg
    /// specification](https://iceberg.apache.org/spec/#schemas-and-data-types).
    /// This value must be `struct`.
    @"type": SchemaV2FieldType,

    pub const json_field_names = .{
        .fields = "fields",
        .identifier_field_ids = "identifierFieldIds",
        .schema_id = "schemaId",
        .@"type" = "type",
    };
};
