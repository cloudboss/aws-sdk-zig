/// A structure containing an LF-tag key-value pair.
pub const LFTagPair = struct {
    /// The identifier for the Data Catalog. By default, the account ID. The Data
    /// Catalog is the persistent metadata store. It contains database definitions,
    /// table definitions, and other control information to manage your Lake
    /// Formation environment.
    catalog_id: ?[]const u8,

    /// The key-name for the LF-tag.
    tag_key: []const u8,

    /// A list of possible values an attribute can take.
    tag_values: []const []const u8,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .tag_key = "TagKey",
        .tag_values = "TagValues",
    };
};
