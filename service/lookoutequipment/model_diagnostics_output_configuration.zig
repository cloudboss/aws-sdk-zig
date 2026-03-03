const ModelDiagnosticsS3OutputConfiguration = @import("model_diagnostics_s3_output_configuration.zig").ModelDiagnosticsS3OutputConfiguration;

/// Output configuration information for the pointwise model diagnostics for an
/// Amazon Lookout for Equipment model.
pub const ModelDiagnosticsOutputConfiguration = struct {
    /// The Amazon Web Services Key Management Service (KMS) key identifier to
    /// encrypt the pointwise model diagnostics files.
    kms_key_id: ?[]const u8 = null,

    /// The Amazon S3 location for the pointwise model diagnostics.
    s3_output_configuration: ModelDiagnosticsS3OutputConfiguration,

    pub const json_field_names = .{
        .kms_key_id = "KmsKeyId",
        .s3_output_configuration = "S3OutputConfiguration",
    };
};
