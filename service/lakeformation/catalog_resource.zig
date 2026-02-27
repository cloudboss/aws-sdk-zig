/// A structure for the catalog object.
pub const CatalogResource = struct {
    /// An identifier for the catalog resource.
    id: ?[]const u8,

    pub const json_field_names = .{
        .id = "Id",
    };
};
