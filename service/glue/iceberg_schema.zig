const IcebergStructField = @import("iceberg_struct_field.zig").IcebergStructField;
const IcebergStructTypeEnum = @import("iceberg_struct_type_enum.zig").IcebergStructTypeEnum;

/// Defines the schema structure for an Iceberg table, including field
/// definitions, data types, and schema metadata.
pub const IcebergSchema = struct {
    /// The list of field definitions that make up the table schema, including field
    /// names, types, and metadata.
    fields: []const IcebergStructField,

    /// The list of field identifiers that uniquely identify records in the table,
    /// used for row-level operations and deduplication.
    identifier_field_ids: ?[]const i32 = null,

    /// The unique identifier for this schema version within the Iceberg table's
    /// schema evolution history.
    schema_id: i32 = 0,

    /// The root type of the schema structure, typically "struct" for Iceberg table
    /// schemas.
    @"type": ?IcebergStructTypeEnum = null,

    pub const json_field_names = .{
        .fields = "Fields",
        .identifier_field_ids = "IdentifierFieldIds",
        .schema_id = "SchemaId",
        .@"type" = "Type",
    };
};
