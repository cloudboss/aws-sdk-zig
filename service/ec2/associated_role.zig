/// Information about the associated IAM roles.
pub const AssociatedRole = struct {
    /// The ARN of the associated IAM role.
    associated_role_arn: ?[]const u8,

    /// The name of the Amazon S3 bucket in which the Amazon S3 object is stored.
    certificate_s_3_bucket_name: ?[]const u8,

    /// The key of the Amazon S3 object where the certificate, certificate chain,
    /// and encrypted private key bundle
    /// are stored. The object key is formatted as follows:
    /// `role_arn`/`certificate_arn`.
    certificate_s_3_object_key: ?[]const u8,

    /// The ID of the KMS key used to encrypt the private key.
    encryption_kms_key_id: ?[]const u8,
};
