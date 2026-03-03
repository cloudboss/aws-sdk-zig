/// Provide the location for output data from a custom classifier job. This
/// field is mandatory
/// if you are training a native document model.
pub const DocumentClassifierOutputDataConfig = struct {
    /// The Amazon S3 prefix for the data lake location of the flywheel statistics.
    flywheel_stats_s3_prefix: ?[]const u8 = null,

    /// ID for the Amazon Web Services Key Management Service (KMS) key that Amazon
    /// Comprehend uses to encrypt the
    /// output results from an analysis job. The KmsKeyId can be one of the
    /// following formats:
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

    /// When you use the `OutputDataConfig` object while creating a custom
    /// classifier, you specify the Amazon S3 location where you want to write the
    /// confusion matrix
    /// and other output files.
    /// The URI must be in the same Region as the API endpoint that you are calling.
    /// The location is
    /// used as the prefix for the actual location of this output file.
    ///
    /// When the custom classifier job is finished, the service creates the output
    /// file in a
    /// directory specific to the job. The `S3Uri` field contains the location of
    /// the
    /// output file, called `output.tar.gz`. It is a compressed archive that
    /// contains the
    /// confusion matrix.
    s3_uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .flywheel_stats_s3_prefix = "FlywheelStatsS3Prefix",
        .kms_key_id = "KmsKeyId",
        .s3_uri = "S3Uri",
    };
};
