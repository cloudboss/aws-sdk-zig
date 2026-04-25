/// Contains details about a schema field in the V2 format. This field format
/// supports nested and complex data types such as `struct`, `list`, and `map`,
/// in addition to primitive types.
pub const SchemaV2Field = struct {
    /// An optional description of the field.
    doc: ?[]const u8 = null,

    /// The unique identifier for the schema field. Field IDs are used by Apache
    /// Iceberg to track schema evolution and maintain compatibility across schema
    /// changes.
    id: i32,

    /// The name of the field.
    name: []const u8,

    /// A Boolean value that specifies whether values are required for each row in
    /// this field. If this is `true`, the field does not allow null values.
    required: bool,

    /// The data type of the field. This can be a primitive type string such as
    /// `boolean`, `int`, `long`, `float`, `double`, `string`, `binary`, `date`,
    /// `timestamp`, or `timestamptz`, or a complex type represented as a JSON
    /// object for nested types such as `struct`, `list`, or `map`. For more
    /// information, see the [Apache Iceberg schemas and data types
    /// documentation](https://iceberg.apache.org/spec/#schemas-and-data-types).
    @"type": []const u8,

    pub const json_field_names = .{
        .doc = "doc",
        .id = "id",
        .name = "name",
        .required = "required",
        .@"type" = "type",
    };
};
