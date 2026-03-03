/// The structure containing the asset properties.
pub const AssetValue = struct {
    /// Link to the asset object.
    href: ?[]const u8 = null,

    pub const json_field_names = .{
        .href = "Href",
    };
};
