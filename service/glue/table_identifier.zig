/// A structure that describes a target table for resource linking.
pub const TableIdentifier = struct {
    /// The ID of the Data Catalog in which the table resides.
    catalog_id: ?[]const u8 = null,

    /// The name of the catalog database that contains the target table.
    database_name: ?[]const u8 = null,

    /// The name of the target table.
    name: ?[]const u8 = null,

    /// Region of the target table.
    region: ?[]const u8 = null,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .database_name = "DatabaseName",
        .name = "Name",
        .region = "Region",
    };
};
