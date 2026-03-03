/// Represents one level between a composite model and the root of the asset.
pub const AssetCompositeModelPathSegment = struct {
    /// The ID of the path segment.
    id: ?[]const u8 = null,

    /// The name of the path segment.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "id",
        .name = "name",
    };
};
