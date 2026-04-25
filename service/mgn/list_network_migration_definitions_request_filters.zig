/// Filters for listing network migration definitions.
pub const ListNetworkMigrationDefinitionsRequestFilters = struct {
    /// A list of definition IDs to filter by.
    network_migration_definition_i_ds: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .network_migration_definition_i_ds = "networkMigrationDefinitionIDs",
    };
};
