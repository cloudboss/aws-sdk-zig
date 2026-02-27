const SchemaDefinition = @import("schema_definition.zig").SchemaDefinition;

/// Contains the configuration information of the Parquet format.
pub const ParquetConfiguration = struct {
    /// Information needed to define a schema.
    schema_definition: ?SchemaDefinition,

    pub const json_field_names = .{
        .schema_definition = "schemaDefinition",
    };
};
