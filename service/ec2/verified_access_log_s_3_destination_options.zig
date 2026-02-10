/// Options for Amazon S3 as a logging destination.
pub const VerifiedAccessLogS3DestinationOptions = struct {
    /// The bucket name.
    bucket_name: ?[]const u8,

    /// The ID of the Amazon Web Services account that owns the Amazon S3 bucket.
    bucket_owner: ?[]const u8,

    /// Indicates whether logging is enabled.
    enabled: bool,

    /// The bucket prefix.
    prefix: ?[]const u8,
};
