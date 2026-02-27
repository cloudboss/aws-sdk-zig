/// Describes a Fleet Advisor collector inventory.
pub const InventoryData = struct {
    /// The number of databases in the Fleet Advisor collector inventory.
    number_of_databases: ?i32,

    /// The number of schemas in the Fleet Advisor collector inventory.
    number_of_schemas: ?i32,

    pub const json_field_names = .{
        .number_of_databases = "NumberOfDatabases",
        .number_of_schemas = "NumberOfSchemas",
    };
};
