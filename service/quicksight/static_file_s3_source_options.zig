/// The structure that contains the Amazon S3 location to download the static
/// file from.
pub const StaticFileS3SourceOptions = struct {
    /// The name of the Amazon S3 bucket.
    bucket_name: []const u8,

    /// The identifier of the static file in the Amazon S3 bucket.
    object_key: []const u8,

    /// The Region of the Amazon S3 account that contains the bucket.
    region: []const u8,

    pub const json_field_names = .{
        .bucket_name = "BucketName",
        .object_key = "ObjectKey",
        .region = "Region",
    };
};
