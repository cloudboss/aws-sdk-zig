/// The identifier information for an Amazon S3 bucket.
pub const S3Identifier = struct {
    /// The name of the S3 bucket.
    s_3_bucket_name: ?[]const u8 = null,

    /// The S3 object key for the S3 resource.
    s_3_object_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .s_3_bucket_name = "s3BucketName",
        .s_3_object_key = "s3ObjectKey",
    };
};
