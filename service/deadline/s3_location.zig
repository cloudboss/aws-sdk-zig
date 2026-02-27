/// The Amazon S3 location information.
pub const S3Location = struct {
    /// The name of the Amazon S3 bucket.
    bucket_name: []const u8,

    /// The Amazon S3 object key that uniquely identifies the Amazon S3 bucket.
    key: []const u8,

    pub const json_field_names = .{
        .bucket_name = "bucketName",
        .key = "key",
    };
};
