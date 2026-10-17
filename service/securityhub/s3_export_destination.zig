/// The Amazon S3 destination for an export, including the bucket, the Amazon
/// Web Services KMS key used for encryption, and an optional object key prefix.
pub const S3ExportDestination = struct {
    /// The Amazon Resource Name (ARN) of the Amazon S3 bucket that Security Hub
    /// writes the export to. You must own the bucket, and its bucket policy must
    /// grant the Security Hub service principal
    /// (`exportv2.securityhub.amazonaws.com`) permission to write objects. For the
    /// required bucket policy, see the Examples section of `StartExportJobV2`.
    bucket_arn: []const u8,

    /// The ARN of the Amazon Web Services KMS key that Security Hub uses to encrypt
    /// the export objects with server-side encryption. The key policy must allow
    /// the Security Hub service principal (`exportv2.securityhub.amazonaws.com`) to
    /// use the key through Amazon S3. For the required key policy, see the Examples
    /// section of `StartExportJobV2`.
    ///
    /// The key must meet all of the following requirements:
    ///
    /// * It must be a symmetric key with a key usage of `ENCRYPT_DECRYPT`.
    ///
    /// * It must be a single-Region key. Multi-Region keys, whose key IDs begin
    ///   with `mrk-`, are rejected.
    ///
    /// * You must specify the full key ARN. Key IDs and aliases are rejected.
    ///
    /// * The key must be in the same Amazon Web Services account as the export job.
    ///
    /// * The key must be in the same Amazon Web Services Region as the export job.
    ///
    /// * The key must be in the `aws`, `aws-cn`, or `aws-us-gov` partition.
    kms_key_arn: []const u8,

    /// An optional key prefix that Security Hub prepends to the Amazon S3 object
    /// keys of the export output. Use a prefix to organize exports within the
    /// bucket. The value can be up to 512 characters.
    object_prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .bucket_arn = "BucketArn",
        .kms_key_arn = "KmsKeyArn",
        .object_prefix = "ObjectPrefix",
    };
};
