const aws = @import("aws");

/// Contains details about a package version asset.
pub const AssetSummary = struct {
    /// The hashes of the asset.
    hashes: ?[]const aws.map.StringMapEntry = null,

    /// The name of the asset.
    name: []const u8,

    /// The size of the asset.
    size: ?i64 = null,

    pub const json_field_names = .{
        .hashes = "hashes",
        .name = "name",
        .size = "size",
    };
};
