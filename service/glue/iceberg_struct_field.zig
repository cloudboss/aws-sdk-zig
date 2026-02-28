/// Defines a single field within an Iceberg table schema, including its
/// identifier, name, data type, nullability, and documentation.
pub const IcebergStructField = struct {
    /// Optional documentation or description text that provides additional context
    /// about the purpose and usage of this field.
    doc: ?[]const u8,

    /// The unique identifier assigned to this field within the Iceberg table
    /// schema, used for schema evolution and field tracking.
    id: i32 = 0,

    /// Default value used to populate the field's value for all records that were
    /// written before the field was added to the schema. This enables backward
    /// compatibility when adding new fields to existing Iceberg tables.
    initial_default: ?[]const u8,

    /// The name of the field as it appears in the table schema and query
    /// operations.
    name: []const u8,

    /// Indicates whether this field is required (non-nullable) or optional
    /// (nullable) in the table schema.
    required: bool = false,

    /// The data type definition for this field, specifying the structure and format
    /// of the data it contains.
    @"type": []const u8,

    /// Default value used to populate the field's value for any records written
    /// after the field was added to the schema, if the writer does not supply the
    /// field's value. This can be changed through schema evolution.
    write_default: ?[]const u8,

    pub const json_field_names = .{
        .doc = "Doc",
        .id = "Id",
        .initial_default = "InitialDefault",
        .name = "Name",
        .required = "Required",
        .@"type" = "Type",
        .write_default = "WriteDefault",
    };
};
