/// A structure that describes a target database for resource linking.
pub const DatabaseIdentifier = struct {
    /// The ID of the Data Catalog in which the database resides.
    catalog_id: ?[]const u8,

    /// The name of the catalog database.
    database_name: ?[]const u8,

    /// Region of the target database.
    region: ?[]const u8,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .database_name = "DatabaseName",
        .region = "Region",
    };
};
