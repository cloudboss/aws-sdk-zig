/// The data-volume encryption details.
pub const EncryptionAtRest = struct {
    /// The ARN of the AWS KMS key for encrypting data at rest. If you don't specify
    /// a KMS key, MSK creates one for you and uses it.
    data_volume_kms_key_id: []const u8,

    pub const json_field_names = .{
        .data_volume_kms_key_id = "DataVolumeKMSKeyId",
    };
};
