const SseType = @import("sse_type.zig").SseType;

/// The encryption configuration for a vector bucket or index. By default, if
/// you don't specify, all new vectors in Amazon S3 vector buckets use
/// server-side encryption with Amazon S3 managed keys (SSE-S3), specifically
/// `AES256`. You can optionally override bucket level encryption settings, and
/// set a specific encryption configuration for a vector index at the time of
/// index creation.
pub const EncryptionConfiguration = struct {
    /// Amazon Web Services Key Management Service (KMS) customer managed key ID to
    /// use for the encryption configuration. This parameter is allowed if and only
    /// if `sseType` is set to `aws:kms`.
    ///
    /// To specify the KMS key, you must use the format of the KMS key Amazon
    /// Resource Name (ARN).
    ///
    /// For example, specify Key ARN in the following format:
    /// `arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab`
    kms_key_arn: ?[]const u8,

    /// The server-side encryption type to use for the encryption configuration of
    /// the vector bucket. By default, if you don't specify, all new vectors in
    /// Amazon S3 vector buckets use server-side encryption with Amazon S3 managed
    /// keys (SSE-S3), specifically `AES256`.
    sse_type: SseType = "AES256",

    pub const json_field_names = .{
        .kms_key_arn = "kmsKeyArn",
        .sse_type = "sseType",
    };
};
