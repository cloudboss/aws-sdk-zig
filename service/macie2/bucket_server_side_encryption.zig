const Type = @import("type.zig").Type;

/// Provides information about the default server-side encryption settings for
/// an S3 bucket. For detailed information about these settings, see [Setting
/// default server-side encryption behavior for Amazon S3
/// buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucket-encryption.html) in the *Amazon Simple Storage Service User Guide*.
pub const BucketServerSideEncryption = struct {
    /// The Amazon Resource Name (ARN) or unique identifier (key ID) for the KMS key
    /// that's used by default to encrypt objects that are added to the bucket. This
    /// value is null if the bucket is configured to use an Amazon S3 managed key to
    /// encrypt new objects.
    kms_master_key_id: ?[]const u8,

    /// The server-side encryption algorithm that's used by default to encrypt
    /// objects that are added to the bucket. Possible values are:
    ///
    /// * AES256 - New objects use SSE-S3 encryption. They're encrypted with an
    ///   Amazon S3 managed key.
    /// * aws:kms - New objects use SSE-KMS encryption. They're encrypted with an
    ///   KMS key (kmsMasterKeyId), either an Amazon Web Services managed key or a
    ///   customer managed key.
    /// * aws:kms:dsse - New objects use DSSE-KMS encryption. They're encrypted with
    ///   an KMS key (kmsMasterKeyId), either an Amazon Web Services managed key or
    ///   a customer managed key.
    /// * NONE - The bucket's default encryption settings don't specify server-side
    ///   encryption behavior for new objects.
    @"type": ?Type,

    pub const json_field_names = .{
        .kms_master_key_id = "kmsMasterKeyId",
        .@"type" = "type",
    };
};
