/// Describes a Fleet Advisor collector inventory.
pub const InventoryData = struct {
    /// The number of databases in the Fleet Advisor collector inventory.
    number_of_databases: ?i32 = null,

    /// The number of schemas in the Fleet Advisor collector inventory.
    number_of_schemas: ?i32 = null,

    pub const json_field_names = .{
        .number_of_databases = "NumberOfDatabases",
        .number_of_schemas = "NumberOfSchemas",
    };
};
