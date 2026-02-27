/// Specify how you want your data keys managed. AWS uses data keys to encrypt
/// your content. AWS also encrypts the data keys themselves, using a customer
/// master key (CMK), and then stores the encrypted data keys alongside your
/// encrypted content. Use this setting to specify which AWS service manages the
/// CMK. For simplest set up, choose Amazon S3. If you want your master key to
/// be managed by AWS Key Management Service (KMS), choose AWS KMS. By default,
/// when you choose AWS KMS, KMS uses the AWS managed customer master key (CMK)
/// associated with Amazon S3 to encrypt your data keys. You can optionally
/// choose to specify a different, customer managed CMK. Do so by specifying the
/// Amazon Resource Name (ARN) of the key for the setting KMS ARN.
pub const S3ServerSideEncryptionType = enum {
    server_side_encryption_s3,
    server_side_encryption_kms,

    pub const json_field_names = .{
        .server_side_encryption_s3 = "SERVER_SIDE_ENCRYPTION_S3",
        .server_side_encryption_kms = "SERVER_SIDE_ENCRYPTION_KMS",
    };
};
