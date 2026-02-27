const IdMappingTableInputSource = @import("id_mapping_table_input_source.zig").IdMappingTableInputSource;

/// Additional properties that are specific to the type of the associated
/// schema.
pub const IdMappingTableSchemaTypeProperties = struct {
    /// Defines which ID namespace associations are used to create the ID mapping
    /// table.
    id_mapping_table_input_source: []const IdMappingTableInputSource,

    pub const json_field_names = .{
        .id_mapping_table_input_source = "idMappingTableInputSource",
    };
};
