/// Content for an asset sourced from an external URL.
pub const AssetSourceUrlContent = struct {
    /// The source URL to import asset content from.
    url: []const u8,

    pub const json_field_names = .{
        .url = "url",
    };
};
