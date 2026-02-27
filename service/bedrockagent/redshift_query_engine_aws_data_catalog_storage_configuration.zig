/// Contains configurations for storage in Glue Data Catalog.
pub const RedshiftQueryEngineAwsDataCatalogStorageConfiguration = struct {
    /// A list of names of the tables to use.
    table_names: []const []const u8,

    pub const json_field_names = .{
        .table_names = "tableNames",
    };
};
