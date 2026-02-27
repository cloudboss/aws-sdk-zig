/// The location of an output object in Amazon S3.
pub const OutPutS3Location = struct {
    /// The object's bucket.
    bucket_name: []const u8,

    /// The object's key.
    object_key: []const u8,

    pub const json_field_names = .{
        .bucket_name = "BucketName",
        .object_key = "ObjectKey",
    };
};
