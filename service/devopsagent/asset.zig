/// Represents an asset in an agent space, including its identifier, type,
/// metadata, version, and timestamps.
pub const Asset = struct {
    /// The unique identifier for this asset
    asset_id: []const u8,

    /// The type of this asset
    asset_type: []const u8,

    /// Timestamp when this asset was created
    created_at: i64,

    /// The metadata for this asset
    metadata: []const u8,

    /// Timestamp when this asset was last updated
    updated_at: i64,

    /// The version number of this asset
    version: i32,

    pub const json_field_names = .{
        .asset_id = "assetId",
        .asset_type = "assetType",
        .created_at = "createdAt",
        .metadata = "metadata",
        .updated_at = "updatedAt",
        .version = "version",
    };
};
