/// Provides configuration parameters for the output of PII entity detection
/// jobs.
pub const PiiOutputDataConfig = struct {
    /// ID for the Amazon Web Services Key Management Service (KMS) key that Amazon
    /// Comprehend uses to encrypt the
    /// output results from an analysis job.
    kms_key_id: ?[]const u8,

    /// When you use the `PiiOutputDataConfig` object with asynchronous operations,
    /// you specify the Amazon S3 location where you want to write the output data.
    ///
    /// For a PII entity detection job, the output file is plain text, not a
    /// compressed archive.
    /// The output file name is the same as the input file, with `.out` appended at
    /// the end.
    s3_uri: []const u8,

    pub const json_field_names = .{
        .kms_key_id = "KmsKeyId",
        .s3_uri = "S3Uri",
    };
};
