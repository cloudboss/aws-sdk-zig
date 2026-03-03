/// An Amazon S3 bucket and optional folder (object key prefix) where SimSpace
/// Weaver creates a file.
pub const S3Destination = struct {
    /// The name of an Amazon S3 bucket. For more information about buckets, see
    /// [Creating,
    /// configuring, and working with Amazon S3
    /// buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/creating-buckets-s3.html) in the *Amazon Simple Storage Service User
    /// Guide*.
    bucket_name: []const u8,

    /// A string prefix for an Amazon S3 object key. It's usually a folder name.
    /// For more information about folders in Amazon S3, see [Organizing objects in
    /// the Amazon S3 console using
    /// folders](https://docs.aws.amazon.com/AmazonS3/latest/userguide/using-folders.html)
    /// in the *Amazon Simple Storage Service User Guide*.
    object_key_prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .bucket_name = "BucketName",
        .object_key_prefix = "ObjectKeyPrefix",
    };
};
