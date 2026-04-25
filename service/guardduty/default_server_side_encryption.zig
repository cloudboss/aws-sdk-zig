/// Contains information on the server side encryption method used in the S3
/// bucket. See [S3 Server-Side
/// Encryption](https://docs.aws.amazon.com/AmazonS3/latest/dev/serv-side-encryption.html) for more information.
pub const DefaultServerSideEncryption = struct {
    /// The type of encryption used for objects within the S3 bucket.
    encryption_type: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the KMS encryption key. Only available if
    /// the bucket `EncryptionType` is `aws:kms`.
    kms_master_key_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .encryption_type = "EncryptionType",
        .kms_master_key_arn = "KmsMasterKeyArn",
    };
};
