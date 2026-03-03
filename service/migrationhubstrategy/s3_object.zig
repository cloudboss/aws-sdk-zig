/// Contains the S3 bucket name and the Amazon S3 key name.
pub const S3Object = struct {
    /// The S3 bucket name.
    s_3_bucket: ?[]const u8 = null,

    /// The Amazon S3 key name.
    s_3_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .s_3_bucket = "s3Bucket",
        .s_3_key = "s3key",
    };
};
