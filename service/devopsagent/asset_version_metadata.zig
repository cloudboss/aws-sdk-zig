/// Metadata for a single version of an asset, including the version number and
/// timestamps.
pub const AssetVersionMetadata = struct {
    /// Timestamp when this asset version was created
    created_at: i64,

    /// Timestamp when this asset version was last updated
    updated_at: i64,

    /// The version number of this asset
    version: i32,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .updated_at = "updatedAt",
        .version = "version",
    };
};
