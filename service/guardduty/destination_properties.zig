/// Contains the Amazon Resource Name (ARN) of the resource to publish to, such
/// as an S3
/// bucket, and the ARN of the KMS key to use to encrypt published findings.
pub const DestinationProperties = struct {
    /// The ARN of the resource to publish to.
    ///
    /// To specify an S3 bucket folder use the following format:
    /// `arn:aws:s3:::DOC-EXAMPLE-BUCKET/myFolder/`
    destination_arn: ?[]const u8,

    /// The ARN of the KMS key to use for encryption.
    kms_key_arn: ?[]const u8,

    pub const json_field_names = .{
        .destination_arn = "DestinationArn",
        .kms_key_arn = "KmsKeyArn",
    };
};
