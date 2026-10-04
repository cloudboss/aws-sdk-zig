/// A summary of an asset type.
pub const AssetTypeItem = struct {
    /// The identifier of the asset type.
    id: ?[]const u8 = null,

    /// The name of the asset type.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "Id",
        .name = "Name",
    };
};
