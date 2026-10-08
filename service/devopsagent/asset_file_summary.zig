/// Summary of a file within an asset, including its path, version, and
/// timestamps.
pub const AssetFileSummary = struct {
    /// Timestamp when this file was created
    created_at: i64,

    /// The metadata for this file
    metadata: ?[]const u8 = null,

    /// The path of this file within the asset
    path: []const u8,

    /// Timestamp when this file was last updated
    updated_at: i64,

    /// The asset version this file belongs to
    version: i32,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .metadata = "metadata",
        .path = "path",
        .updated_at = "updatedAt",
        .version = "version",
    };
};
