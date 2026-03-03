const S3EncryptionOption = @import("s3_encryption_option.zig").S3EncryptionOption;

/// Details on S3 location for error reports that result from running a query.
pub const S3Configuration = struct {
    /// Name of the S3 bucket under which error reports will be created.
    bucket_name: []const u8,

    /// Encryption at rest options for the error reports. If no encryption option is
    /// specified, Timestream will choose SSE_S3 as default.
    encryption_option: ?S3EncryptionOption = null,

    /// Prefix for the error report key. Timestream by default adds the following
    /// prefix to
    /// the error report path.
    object_key_prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .bucket_name = "BucketName",
        .encryption_option = "EncryptionOption",
        .object_key_prefix = "ObjectKeyPrefix",
    };
};
