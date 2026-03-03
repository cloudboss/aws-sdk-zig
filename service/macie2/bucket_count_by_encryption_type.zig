/// Provides information about the number of S3 buckets whose settings do or
/// don't specify default server-side encryption behavior for objects that are
/// added to the buckets. For detailed information about these settings, see
/// [Setting default server-side encryption behavior for Amazon S3
/// buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucket-encryption.html) in the *Amazon Simple Storage Service User Guide*.
pub const BucketCountByEncryptionType = struct {
    /// The total number of buckets whose default encryption settings are configured
    /// to encrypt new objects with an KMS key, either an Amazon Web Services
    /// managed key or a customer managed key. By default, these buckets encrypt new
    /// objects automatically using DSSE-KMS or SSE-KMS encryption.
    kms_managed: ?i64 = null,

    /// The total number of buckets whose default encryption settings are configured
    /// to encrypt new objects with an Amazon S3 managed key. By default, these
    /// buckets encrypt new objects automatically using SSE-S3 encryption.
    s_3_managed: ?i64 = null,

    /// The total number of buckets that don't specify default server-side
    /// encryption behavior for new objects. Default encryption settings aren't
    /// configured for these buckets.
    unencrypted: ?i64 = null,

    /// The total number of buckets that Amazon Macie doesn't have current
    /// encryption metadata for. For example, the buckets' permissions settings or a
    /// quota prevented Macie from retrieving the default encryption settings for
    /// the buckets.
    unknown: ?i64 = null,

    pub const json_field_names = .{
        .kms_managed = "kmsManaged",
        .s_3_managed = "s3Managed",
        .unencrypted = "unencrypted",
        .unknown = "unknown",
    };
};
