/// An object containing `KMSArn`, `outputS3Path`, and `roleARN`.
pub const IdMappingJobOutputSource = struct {
    /// Customer KMS ARN for encryption at rest. If not provided, system will use an
    /// Entity Resolution managed KMS key.
    kms_arn: ?[]const u8 = null,

    /// The S3 path to which Entity Resolution will write the output table.
    output_s3_path: []const u8,

    /// The Amazon Resource Name (ARN) of the IAM role. Entity Resolution assumes
    /// this role to access Amazon Web Services resources on your behalf as part of
    /// workflow execution.
    role_arn: []const u8,

    pub const json_field_names = .{
        .kms_arn = "KMSArn",
        .output_s3_path = "outputS3Path",
        .role_arn = "roleArn",
    };
};
