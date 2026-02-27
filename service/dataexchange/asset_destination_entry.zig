/// The destination for the asset.
pub const AssetDestinationEntry = struct {
    /// The unique identifier for the asset.
    asset_id: []const u8,

    /// The Amazon S3 bucket that is the destination for the asset.
    bucket: []const u8,

    /// The name of the object in Amazon S3 for the asset.
    key: ?[]const u8,

    pub const json_field_names = .{
        .asset_id = "AssetId",
        .bucket = "Bucket",
        .key = "Key",
    };
};
