const JsonSchemaDefinition = @import("json_schema_definition.zig").JsonSchemaDefinition;

/// The structure that the model's output must adhere to.
pub const OutputFormatStructure = union(enum) {
    /// A JSON schema structure that the model's output must adhere to.
    json_schema: ?JsonSchemaDefinition,

    pub const json_field_names = .{
        .json_schema = "jsonSchema",
    };
};
