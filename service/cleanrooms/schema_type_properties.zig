const IdMappingTableSchemaTypeProperties = @import("id_mapping_table_schema_type_properties.zig").IdMappingTableSchemaTypeProperties;

/// Information about the schema type properties.
pub const SchemaTypeProperties = union(enum) {
    /// The ID mapping table for the schema type properties.
    id_mapping_table: ?IdMappingTableSchemaTypeProperties,

    pub const json_field_names = .{
        .id_mapping_table = "idMappingTable",
    };
};
