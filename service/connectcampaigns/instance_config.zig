const EncryptionConfig = @import("encryption_config.zig").EncryptionConfig;

/// Instance config object
pub const InstanceConfig = struct {
    connect_instance_id: []const u8,

    encryption_config: EncryptionConfig,

    service_linked_role_arn: []const u8,

    pub const json_field_names = .{
        .connect_instance_id = "connectInstanceId",
        .encryption_config = "encryptionConfig",
        .service_linked_role_arn = "serviceLinkedRoleArn",
    };
};
