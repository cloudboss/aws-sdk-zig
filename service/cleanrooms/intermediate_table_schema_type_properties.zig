/// Contains the schema type properties for an intermediate table.
pub const IntermediateTableSchemaTypeProperties = struct {
    /// The unique identifier of the intermediate table.
    intermediate_table_id: []const u8,

    pub const json_field_names = .{
        .intermediate_table_id = "intermediateTableId",
    };
};
