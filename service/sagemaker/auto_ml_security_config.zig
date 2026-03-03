const VpcConfig = @import("vpc_config.zig").VpcConfig;

/// Security options.
pub const AutoMLSecurityConfig = struct {
    /// Whether to use traffic encryption between the container layers.
    enable_inter_container_traffic_encryption: ?bool = null,

    /// The key used to encrypt stored data.
    volume_kms_key_id: ?[]const u8 = null,

    /// The VPC configuration.
    vpc_config: ?VpcConfig = null,

    pub const json_field_names = .{
        .enable_inter_container_traffic_encryption = "EnableInterContainerTrafficEncryption",
        .volume_kms_key_id = "VolumeKmsKeyId",
        .vpc_config = "VpcConfig",
    };
};
