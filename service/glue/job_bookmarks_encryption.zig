const JobBookmarksEncryptionMode = @import("job_bookmarks_encryption_mode.zig").JobBookmarksEncryptionMode;

/// Specifies how job bookmark data should be encrypted.
pub const JobBookmarksEncryption = struct {
    /// The encryption mode to use for job bookmarks data.
    job_bookmarks_encryption_mode: ?JobBookmarksEncryptionMode,

    /// The Amazon Resource Name (ARN) of the KMS key to be used to encrypt the
    /// data.
    kms_key_arn: ?[]const u8,

    pub const json_field_names = .{
        .job_bookmarks_encryption_mode = "JobBookmarksEncryptionMode",
        .kms_key_arn = "KmsKeyArn",
    };
};
