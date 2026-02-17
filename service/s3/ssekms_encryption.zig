/// If `SSEKMS` is specified for `ObjectEncryption`, this data type specifies
/// the Amazon Web Services KMS key Amazon Resource Name (ARN) to use and
/// whether to use an S3 Bucket Key for
/// server-side encryption using Key Management Service (KMS) keys (SSE-KMS).
pub const SSEKMSEncryption = struct {
    /// Specifies whether Amazon S3 should use an S3 Bucket Key for object
    /// encryption with server-side encryption
    /// using Key Management Service (KMS) keys (SSE-KMS). If this value isn't
    /// specified, it defaults to `false`.
    /// Setting this value to `true` causes Amazon S3 to use an S3 Bucket Key for
    /// object encryption with
    /// SSE-KMS. For more information, see
    /// [
    /// Using Amazon S3 Bucket
    /// Keys](https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucket-key.html)
    /// in the *Amazon S3 User Guide*.
    ///
    /// Valid Values: `true` | `false`
    bucket_key_enabled: ?bool,

    /// Specifies the Amazon Web Services KMS key Amazon Resource Name (ARN) to use
    /// for the updated server-side encryption
    /// type. Required if `ObjectEncryption` specifies `SSEKMS`.
    ///
    /// You must specify the full Amazon Web Services KMS key ARN. The KMS key ID
    /// and KMS key alias aren't
    /// supported.
    ///
    /// Pattern: (`arn:aws[-a-z0-9]*:kms:[-a-z0-9]*:[0-9]{12}:key/.+`)
    kms_key_arn: []const u8,
};
