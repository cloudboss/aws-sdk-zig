/// An object representing an Glue table.
pub const DataQualityTargetTable = struct {
    /// The catalog id where the Glue table exists.
    catalog_id: ?[]const u8,

    /// The name of the database where the Glue table exists.
    database_name: []const u8,

    /// The name of the Glue table.
    table_name: []const u8,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .database_name = "DatabaseName",
        .table_name = "TableName",
    };
};
