/// Provides configuration parameters for the output of inference jobs.
pub const OutputDataConfig = struct {
    /// ID for the Amazon Web Services Key Management Service (KMS) key that Amazon
    /// Comprehend uses to encrypt the
    /// output results from an analysis job. Specify the Key Id of a symmetric key,
    /// because you cannot use an asymmetric
    /// key for uploading data to S3.
    ///
    /// The KmsKeyId can be one of the following formats:
    ///
    /// * KMS Key ID: `"1234abcd-12ab-34cd-56ef-1234567890ab"`
    ///
    /// * Amazon Resource Name (ARN) of a KMS Key:
    /// `"arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"`
    ///
    /// * KMS Key Alias: `"alias/ExampleAlias"`
    ///
    /// * ARN of a KMS Key Alias:
    /// `"arn:aws:kms:us-west-2:111122223333:alias/ExampleAlias"`
    kms_key_id: ?[]const u8 = null,

    /// When you use the `OutputDataConfig` object with asynchronous operations, you
    /// specify the Amazon S3 location where you want to write the output data. The
    /// URI must be in the
    /// same Region as the API endpoint that you are calling. The location is used
    /// as the prefix for
    /// the actual location of the output file.
    ///
    /// When the topic detection job is finished, the service creates an output file
    /// in a
    /// directory specific to the job. The `S3Uri` field contains the location of
    /// the
    /// output file, called `output.tar.gz`. It is a compressed archive that
    /// contains the
    /// ouput of the operation.
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
