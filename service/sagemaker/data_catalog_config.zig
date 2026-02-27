/// The meta data of the Glue table which serves as data catalog for the
/// `OfflineStore`.
pub const DataCatalogConfig = struct {
    /// The name of the Glue table catalog.
    catalog: []const u8,

    /// The name of the Glue table database.
    database: []const u8,

    /// The name of the Glue table.
    table_name: []const u8,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .database = "Database",
        .table_name = "TableName",
    };
};
