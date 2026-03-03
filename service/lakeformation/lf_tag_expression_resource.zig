/// A structure containing a LF-Tag expression (keys and values).
pub const LFTagExpressionResource = struct {
    /// The identifier for the Data Catalog. By default, the account ID.
    catalog_id: ?[]const u8 = null,

    /// The name of the LF-Tag expression to grant permissions on.
    name: []const u8,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .name = "Name",
    };
};
