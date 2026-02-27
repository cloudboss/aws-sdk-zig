/// The container for the regional bucket.
pub const RegionalBucket = struct {
    bucket: []const u8,

    /// The Amazon Resource Name (ARN) for the regional bucket.
    bucket_arn: ?[]const u8,

    /// The creation date of the regional bucket
    creation_date: i64,

    /// The Outposts ID of the regional bucket.
    outpost_id: ?[]const u8,

    public_access_block_enabled: bool = false,
};
