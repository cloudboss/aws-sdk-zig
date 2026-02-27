/// Provides information about an S3 object that lists specific text to ignore.
pub const S3WordsList = struct {
    /// The full name of the S3 bucket that contains the object.
    bucket_name: []const u8,

    /// The full name (key) of the object.
    object_key: []const u8,

    pub const json_field_names = .{
        .bucket_name = "bucketName",
        .object_key = "objectKey",
    };
};
