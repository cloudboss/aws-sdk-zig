/// The output source for the ID mapping workflow.
pub const IdMappingWorkflowOutputSource = struct {
    /// Customer KMS ARN for encryption at rest. If not provided, system will use an
    /// Entity Resolution managed KMS key.
    kms_arn: ?[]const u8,

    /// The S3 path to which Entity Resolution will write the output table.
    output_s3_path: []const u8,

    pub const json_field_names = .{
        .kms_arn = "KMSArn",
        .output_s3_path = "outputS3Path",
    };
};
