/// The Amazon Resource Name (ARN) of the AWS KMS key used to encrypt the shared
/// S3
/// objects.
pub const KmsKeyToGrant = struct {
    /// The AWS KMS CMK (Key Management System Customer Managed Key) used to encrypt
    /// S3 objects
    /// in the shared S3 Bucket. AWS Data exchange will create a KMS grant for each
    /// subscriber to
    /// allow them to access and decrypt their entitled data that is encrypted using
    /// this KMS key
    /// specified.
    kms_key_arn: []const u8,

    pub const json_field_names = .{
        .kms_key_arn = "KmsKeyArn",
    };
};
