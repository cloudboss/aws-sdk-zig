/// Configuration to control how SageMaker captures inference data for batch
/// transform jobs.
pub const BatchDataCaptureConfig = struct {
    /// The Amazon S3 location being used to capture the data.
    destination_s3_uri: []const u8,

    /// Flag that indicates whether to append inference id to the output.
    generate_inference_id: ?bool,

    /// The Amazon Resource Name (ARN) of a Amazon Web Services Key Management
    /// Service key that SageMaker uses to encrypt data on the storage volume
    /// attached to the ML compute instance that hosts the batch transform job.
    ///
    /// The KmsKeyId can be any of the following formats:
    ///
    /// * Key ID: `1234abcd-12ab-34cd-56ef-1234567890ab`
    /// * Key ARN:
    ///   `arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab`
    /// * Alias name: `alias/ExampleAlias`
    /// * Alias name ARN: `arn:aws:kms:us-west-2:111122223333:alias/ExampleAlias`
    kms_key_id: ?[]const u8,

    pub const json_field_names = .{
        .destination_s3_uri = "DestinationS3Uri",
        .generate_inference_id = "GenerateInferenceId",
        .kms_key_id = "KmsKeyId",
    };
};
