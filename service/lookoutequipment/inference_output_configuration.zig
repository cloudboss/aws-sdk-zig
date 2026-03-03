const InferenceS3OutputConfiguration = @import("inference_s3_output_configuration.zig").InferenceS3OutputConfiguration;

/// Specifies configuration information for the output results from for the
/// inference,
/// including KMS key ID and output S3 location.
pub const InferenceOutputConfiguration = struct {
    /// The ID number for the KMS key key used to encrypt the inference output.
    kms_key_id: ?[]const u8 = null,

    /// Specifies configuration information for the output results from for the
    /// inference,
    /// output S3 location.
    s3_output_configuration: InferenceS3OutputConfiguration,

    pub const json_field_names = .{
        .kms_key_id = "KmsKeyId",
        .s3_output_configuration = "S3OutputConfiguration",
    };
};
