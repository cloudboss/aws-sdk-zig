/// Contains details about a schema field.
pub const SchemaField = struct {
    /// An optional unique identifier for the schema field. Field IDs are used by
    /// Apache Iceberg to track schema evolution and maintain compatibility across
    /// schema changes. If not specified, S3 Tables automatically assigns field IDs.
    id: ?i32 = null,

    /// The name of the field.
    name: []const u8,

    /// A Boolean value that specifies whether values are required for each row in
    /// this field. By default, this is `false` and null values are allowed in the
    /// field. If this is `true` the field does not allow null values.
    required: bool = false,

    /// The field type. S3 Tables supports all Apache Iceberg primitive types. For
    /// more information, see the [Apache Iceberg
    /// documentation](https://iceberg.apache.org/spec/#primitive-types).
    @"type": []const u8,

    pub const json_field_names = .{
        .id = "id",
        .name = "name",
        .required = "required",
        .@"type" = "type",
    };
};
