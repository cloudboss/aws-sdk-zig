/// The configuration settings for the S3 bucket.
pub const S3BucketSinkConfiguration = struct {
    /// The destination URL of the S3 bucket.
    destination: []const u8,

    pub const json_field_names = .{
        .destination = "Destination",
    };
};
