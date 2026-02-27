/// The name and prefix of the Amazon S3 bucket where AWS Signer saves your
/// signed objects.
pub const S3Destination = struct {
    /// Name of the S3 bucket.
    bucket_name: ?[]const u8,

    /// An S3 prefix that you can use to limit responses to those that begin with
    /// the specified
    /// prefix.
    prefix: ?[]const u8,

    pub const json_field_names = .{
        .bucket_name = "bucketName",
        .prefix = "prefix",
    };
};
