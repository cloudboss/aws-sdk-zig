/// A location in Amazon S3.
pub const S3Location = struct {
    /// A bucket name.
    bucket_name: []const u8,

    /// An object key.
    object_key: []const u8,

    /// The bucket's Region.
    region: ?[]const u8,

    pub const json_field_names = .{
        .bucket_name = "BucketName",
        .object_key = "ObjectKey",
        .region = "Region",
    };
};
