const EncryptionConfig = @import("encryption_config.zig").EncryptionConfig;

/// Information about the Amazon Simple Storage Service (Amazon S3) storage
/// type.
pub const S3Config = struct {
    /// The S3 bucket name.
    bucket_name: []const u8,

    /// The S3 bucket prefix.
    bucket_prefix: []const u8,

    /// The Amazon S3 encryption configuration.
    encryption_config: ?EncryptionConfig = null,

    pub const json_field_names = .{
        .bucket_name = "BucketName",
        .bucket_prefix = "BucketPrefix",
        .encryption_config = "EncryptionConfig",
    };
};
