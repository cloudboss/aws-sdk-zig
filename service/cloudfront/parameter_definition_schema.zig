const StringSchemaConfig = @import("string_schema_config.zig").StringSchemaConfig;

/// An object that contains information about the parameter definition.
pub const ParameterDefinitionSchema = struct {
    /// An object that contains information about the string schema.
    string_schema: ?StringSchemaConfig = null,
};
