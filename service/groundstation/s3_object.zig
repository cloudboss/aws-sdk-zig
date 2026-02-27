/// Object stored in Amazon S3 containing ephemeris data.
pub const S3Object = struct {
    /// An Amazon S3 Bucket name.
    bucket: ?[]const u8,

    /// An Amazon S3 key for the ephemeris.
    key: ?[]const u8,

    /// For versioned Amazon S3 objects, the version to use for the ephemeris.
    version: ?[]const u8,

    pub const json_field_names = .{
        .bucket = "bucket",
        .key = "key",
        .version = "version",
    };
};
