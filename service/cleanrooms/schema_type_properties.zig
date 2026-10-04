const ConfiguredTableAssociationSchemaTypeProperties = @import("configured_table_association_schema_type_properties.zig").ConfiguredTableAssociationSchemaTypeProperties;
const IdMappingTableSchemaTypeProperties = @import("id_mapping_table_schema_type_properties.zig").IdMappingTableSchemaTypeProperties;
const IntermediateTableSchemaTypeProperties = @import("intermediate_table_schema_type_properties.zig").IntermediateTableSchemaTypeProperties;

/// Information about the schema type properties.
pub const SchemaTypeProperties = union(enum) {
    /// The schema type properties for a configured table association.
    configured_table_association: ?ConfiguredTableAssociationSchemaTypeProperties,
    /// The ID mapping table for the schema type properties.
    id_mapping_table: ?IdMappingTableSchemaTypeProperties,
    /// The schema type properties for an intermediate table.
    intermediate_table: ?IntermediateTableSchemaTypeProperties,

    pub const json_field_names = .{
        .configured_table_association = "configuredTableAssociation",
        .id_mapping_table = "idMappingTable",
        .intermediate_table = "intermediateTable",
    };
};
