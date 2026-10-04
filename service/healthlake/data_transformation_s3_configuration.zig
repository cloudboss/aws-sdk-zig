/// The Amazon S3 output configuration for a data transformation job, including
/// the output location and encryption settings.
pub const DataTransformationS3Configuration = struct {
    /// The Amazon Web Services Key Management Service (Amazon Web Services KMS) key
    /// identifier used to encrypt the transformation job output written to Amazon
    /// S3.
    kms_key_id: []const u8,

    /// The Amazon S3 URI where HealthLake writes the converted output files.
    s3_uri: []const u8,

    pub const json_field_names = .{
        .kms_key_id = "KmsKeyId",
        .s3_uri = "S3Uri",
    };
};
