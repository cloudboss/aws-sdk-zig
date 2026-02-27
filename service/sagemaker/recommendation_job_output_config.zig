const RecommendationJobCompiledOutputConfig = @import("recommendation_job_compiled_output_config.zig").RecommendationJobCompiledOutputConfig;

/// Provides information about the output configuration for the compiled model.
pub const RecommendationJobOutputConfig = struct {
    /// Provides information about the output configuration for the compiled model.
    compiled_output_config: ?RecommendationJobCompiledOutputConfig,

    /// The Amazon Resource Name (ARN) of a Amazon Web Services Key Management
    /// Service (Amazon Web Services KMS) key that Amazon SageMaker uses to encrypt
    /// your output artifacts with Amazon S3 server-side encryption. The SageMaker
    /// execution role must have `kms:GenerateDataKey` permission.
    ///
    /// The `KmsKeyId` can be any of the following formats:
    ///
    /// * // KMS Key ID
    ///
    /// `"1234abcd-12ab-34cd-56ef-1234567890ab"`
    /// * // Amazon Resource Name (ARN) of a KMS Key
    ///
    /// `"arn:aws:kms:<region>:<account>:key/<key-id-12ab-34cd-56ef-1234567890ab>"`
    /// * // KMS Key Alias
    ///
    /// `"alias/ExampleAlias"`
    /// * // Amazon Resource Name (ARN) of a KMS Key Alias
    ///
    /// `"arn:aws:kms:<region>:<account>:alias/<ExampleAlias>"`
    ///
    /// For more information about key identifiers, see [Key identifiers
    /// (KeyID)](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#key-id-key-id) in the Amazon Web Services Key Management Service (Amazon Web Services KMS) documentation.
    kms_key_id: ?[]const u8,

    pub const json_field_names = .{
        .compiled_output_config = "CompiledOutputConfig",
        .kms_key_id = "KmsKeyId",
    };
};
