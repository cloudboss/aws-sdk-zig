/// An Key Management Service (KMS) key and an Identity and Access Management
/// (IAM) role that Amazon Forecast can assume to
/// access the key. You can specify this optional object in the
/// CreateDataset and CreatePredictor requests.
pub const EncryptionConfig = struct {
    /// The Amazon Resource Name (ARN) of the KMS key.
    kms_key_arn: []const u8,

    /// The ARN of the IAM role that Amazon Forecast can assume to access the KMS
    /// key.
    ///
    /// Passing a role across Amazon Web Services accounts is not allowed. If you
    /// pass a role that isn't in your
    /// account, you get an `InvalidInputException` error.
    role_arn: []const u8,

    pub const json_field_names = .{
        .kms_key_arn = "KMSKeyArn",
        .role_arn = "RoleArn",
    };
};
