/// Contains information about where human output will be stored.
pub const FlowDefinitionOutputConfig = struct {
    /// The Amazon Key Management Service (KMS) key ID for server-side encryption.
    kms_key_id: ?[]const u8 = null,

    /// The Amazon S3 path where the object containing human output will be made
    /// available.
    ///
    /// To learn more about the format of Amazon A2I output data, see [Amazon A2I
    /// Output
    /// Data](https://docs.aws.amazon.com/sagemaker/latest/dg/a2i-output-data.html).
    s3_output_path: []const u8,

    pub const json_field_names = .{
        .kms_key_id = "KmsKeyId",
        .s3_output_path = "S3OutputPath",
    };
};
