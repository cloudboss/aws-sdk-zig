/// A structure for the database object.
pub const DatabaseResource = struct {
    /// The identifier for the Data Catalog. By default, it is the account ID of the
    /// caller.
    catalog_id: ?[]const u8,

    /// The name of the database resource. Unique to the Data Catalog.
    name: []const u8,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .name = "Name",
    };
};
