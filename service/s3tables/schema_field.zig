/// Contains details about a schema field.
pub const SchemaField = struct {
    /// The name of the field.
    name: []const u8,

    /// A Boolean value that specifies whether values are required for each row in
    /// this field. By default, this is `false` and null values are allowed in the
    /// field. If this is `true` the field does not allow null values.
    required: bool = false,

    /// The field type. S3 Tables supports all Apache Iceberg primitive types. For
    /// more information, see the [Apache Iceberg
    /// documentation](https://iceberg.apache.org/spec/#primitive-types).
    type: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .required = "required",
        .type = "type",
    };
};
