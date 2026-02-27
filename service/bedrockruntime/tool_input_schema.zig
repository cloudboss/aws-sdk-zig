/// The schema for the tool. The top level schema type must be `object`. For
/// more information, see [Call a tool with the Converse
/// API](https://docs.aws.amazon.com/bedrock/latest/userguide/tool-use.html) in
/// the Amazon Bedrock User Guide.
pub const ToolInputSchema = union(enum) {
    /// The JSON schema for the tool. For more information, see [JSON Schema
    /// Reference](https://json-schema.org/understanding-json-schema/reference).
    json: ?[]const u8,

    pub const json_field_names = .{
        .json = "json",
    };
};
