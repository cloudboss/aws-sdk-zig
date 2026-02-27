/// Represents one level between a composite model and the root of the asset
/// model.
pub const AssetModelCompositeModelPathSegment = struct {
    /// The ID of the path segment.
    id: ?[]const u8,

    /// The name of the path segment.
    name: ?[]const u8,

    pub const json_field_names = .{
        .id = "id",
        .name = "name",
    };
};
