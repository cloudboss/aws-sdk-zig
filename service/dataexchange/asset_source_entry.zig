/// The source of the assets.
pub const AssetSourceEntry = struct {
    /// The Amazon S3 bucket that's part of the source of the asset.
    bucket: []const u8,

    /// The name of the object in Amazon S3 for the asset.
    key: []const u8,

    pub const json_field_names = .{
        .bucket = "Bucket",
        .key = "Key",
    };
};
