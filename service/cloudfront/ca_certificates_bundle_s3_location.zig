/// The CA certificates bundle location in Amazon S3.
pub const CaCertificatesBundleS3Location = struct {
    /// The S3 bucket.
    bucket: []const u8,

    /// The location's key.
    key: []const u8,

    /// The location's Region.
    region: []const u8,

    /// The location's version.
    version: ?[]const u8 = null,
};
