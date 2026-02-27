/// Specifies a table definition in the Glue Data Catalog.
pub const CatalogEntry = struct {
    /// The database in which the table metadata resides.
    database_name: []const u8,

    /// The name of the table in question.
    table_name: []const u8,

    pub const json_field_names = .{
        .database_name = "DatabaseName",
        .table_name = "TableName",
    };
};
