/// Specifies a MySQL data source in the Glue Data Catalog.
pub const MySQLCatalogSource = struct {
    /// The name of the database to read from.
    database: []const u8,

    /// The name of the data source.
    name: []const u8,

    /// The name of the table in the database to read from.
    table: []const u8,

    pub const json_field_names = .{
        .database = "Database",
        .name = "Name",
        .table = "Table",
    };
};
