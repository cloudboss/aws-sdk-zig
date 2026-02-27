/// The data-volume encryption details. You can't update encryption at rest
/// settings for existing clusters.
pub const AwsMskClusterClusterInfoEncryptionInfoEncryptionAtRestDetails = struct {
    /// The Amazon Resource Name (ARN) of the KMS key for encrypting data at rest.
    /// If you don't specify a
    /// KMS key, MSK creates one for you and uses it.
    data_volume_kms_key_id: ?[]const u8,

    pub const json_field_names = .{
        .data_volume_kms_key_id = "DataVolumeKMSKeyId",
    };
};
