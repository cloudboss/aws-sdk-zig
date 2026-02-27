/// JSON schema structured output format options.
pub const JsonSchemaDefinition = struct {
    /// A description of the JSON schema.
    description: ?[]const u8,

    /// The name of the JSON schema.
    name: ?[]const u8,

    /// The JSON schema to constrain the model's output. For more information, see
    /// [JSON Schema
    /// Reference](https://json-schema.org/understanding-json-schema/reference).
    schema: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
        .schema = "schema",
    };
};
