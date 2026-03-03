/// A structure for a data cells filter resource.
pub const DataCellsFilterResource = struct {
    /// A database in the Glue Data Catalog.
    database_name: ?[]const u8 = null,

    /// The name of the data cells filter.
    name: ?[]const u8 = null,

    /// The ID of the catalog to which the table belongs.
    table_catalog_id: ?[]const u8 = null,

    /// The name of the table.
    table_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .database_name = "DatabaseName",
        .name = "Name",
        .table_catalog_id = "TableCatalogId",
        .table_name = "TableName",
    };
};
