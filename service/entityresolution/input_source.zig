/// An object containing `inputSourceARN`, `schemaName`, and
/// `applyNormalization`.
pub const InputSource = struct {
    /// Normalizes the attributes defined in the schema in the input data. For
    /// example, if an attribute has an `AttributeType` of `PHONE_NUMBER`, and the
    /// data in the input table is in a format of 1234567890, Entity Resolution will
    /// normalize this field in the output to (123)-456-7890.
    apply_normalization: ?bool = null,

    /// An Glue table Amazon Resource Name (ARN) for the input source table.
    input_source_arn: []const u8,

    /// The name of the schema to be retrieved.
    schema_name: []const u8,

    pub const json_field_names = .{
        .apply_normalization = "applyNormalization",
        .input_source_arn = "inputSourceARN",
        .schema_name = "schemaName",
    };
};
