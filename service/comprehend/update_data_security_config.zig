const VpcConfig = @import("vpc_config.zig").VpcConfig;

/// Data security configuration.
pub const UpdateDataSecurityConfig = struct {
    /// ID for the KMS key that Amazon Comprehend uses to encrypt
    /// trained custom models. The ModelKmsKeyId can be either of the following
    /// formats:
    ///
    /// * KMS Key ID: `"1234abcd-12ab-34cd-56ef-1234567890ab"`
    ///
    /// * Amazon Resource Name (ARN) of a KMS Key:
    /// `"arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"`
    model_kms_key_id: ?[]const u8 = null,

    /// ID for the KMS key that Amazon Comprehend uses to encrypt the volume.
    volume_kms_key_id: ?[]const u8 = null,

    vpc_config: ?VpcConfig = null,

    pub const json_field_names = .{
        .model_kms_key_id = "ModelKmsKeyId",
        .volume_kms_key_id = "VolumeKmsKeyId",
        .vpc_config = "VpcConfig",
    };
};
