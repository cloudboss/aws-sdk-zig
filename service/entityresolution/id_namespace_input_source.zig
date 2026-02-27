/// An object containing `inputSourceARN` and `schemaName`.
pub const IdNamespaceInputSource = struct {
    /// An Glue table Amazon Resource Name (ARN) or a matching workflow ARN for the
    /// input source table.
    input_source_arn: []const u8,

    /// The name of the schema.
    schema_name: ?[]const u8,

    pub const json_field_names = .{
        .input_source_arn = "inputSourceARN",
        .schema_name = "schemaName",
    };
};
