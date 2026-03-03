const SchemaDefinition = @import("schema_definition.zig").SchemaDefinition;

/// A union of schema types.
pub const SchemaUnion = struct {
    /// The configuration for a schema on a tabular Dataset.
    tabular_schema_config: ?SchemaDefinition = null,

    pub const json_field_names = .{
        .tabular_schema_config = "tabularSchemaConfig",
    };
};
