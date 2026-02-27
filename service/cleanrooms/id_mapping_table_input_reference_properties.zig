const IdMappingTableInputSource = @import("id_mapping_table_input_source.zig").IdMappingTableInputSource;

/// The input reference properties for the ID mapping table.
pub const IdMappingTableInputReferenceProperties = struct {
    /// The input source of the ID mapping table.
    id_mapping_table_input_source: []const IdMappingTableInputSource,

    pub const json_field_names = .{
        .id_mapping_table_input_source = "idMappingTableInputSource",
    };
};
