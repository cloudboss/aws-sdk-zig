/// Provides information about the number of objects that are in an S3 bucket
/// and use certain types of server-side encryption, use client-side encryption,
/// or aren't encrypted.
pub const ObjectCountByEncryptionType = struct {
    /// The total number of objects that are encrypted with customer-provided keys.
    /// The objects use server-side encryption with customer-provided keys (SSE-C).
    customer_managed: ?i64 = null,

    /// The total number of objects that are encrypted with KMS keys, either Amazon
    /// Web Services managed keys or customer managed keys. The objects use
    /// dual-layer server-side encryption or server-side encryption with KMS keys
    /// (DSSE-KMS or SSE-KMS).
    kms_managed: ?i64 = null,

    /// The total number of objects that are encrypted with Amazon S3 managed keys.
    /// The objects use server-side encryption with Amazon S3 managed keys (SSE-S3).
    s_3_managed: ?i64 = null,

    /// The total number of objects that use client-side encryption or aren't
    /// encrypted.
    unencrypted: ?i64 = null,

    /// The total number of objects that Amazon Macie doesn't have current
    /// encryption metadata for. Macie can't provide current data about the
    /// encryption settings for these objects.
    unknown: ?i64 = null,

    pub const json_field_names = .{
        .customer_managed = "customerManaged",
        .kms_managed = "kmsManaged",
        .s_3_managed = "s3Managed",
        .unencrypted = "unencrypted",
        .unknown = "unknown",
    };
};
