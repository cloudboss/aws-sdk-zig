const S3EncryptionOption = @import("s3_encryption_option.zig").S3EncryptionOption;

pub const ReportS3Configuration = struct {
    bucket_name: []const u8,

    encryption_option: ?S3EncryptionOption,

    kms_key_id: ?[]const u8,

    object_key_prefix: ?[]const u8,

    pub const json_field_names = .{
        .bucket_name = "BucketName",
        .encryption_option = "EncryptionOption",
        .kms_key_id = "KmsKeyId",
        .object_key_prefix = "ObjectKeyPrefix",
    };
};
