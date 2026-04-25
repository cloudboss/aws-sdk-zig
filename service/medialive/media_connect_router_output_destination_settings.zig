const MediaConnectRouterOutputEncryptionType = @import("media_connect_router_output_encryption_type.zig").MediaConnectRouterOutputEncryptionType;

/// MediaConnect Router Output Destination Settings
pub const MediaConnectRouterOutputDestinationSettings = struct {
    /// Encryption configuration for MediaConnect router. When using SECRETS_MANAGER
    /// encryption, you must provide the ARN of the secret used to encrypt data in
    /// transit. When using AUTOMATIC encryption, a service-managed secret will be
    /// used instead.
    encryption_type: ?MediaConnectRouterOutputEncryptionType = null,

    /// ARN of the secret used to encrypt this input. Used only with the
    /// SECRETS_MANAGER encryption type.
    secret_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .encryption_type = "EncryptionType",
        .secret_arn = "SecretArn",
    };
};
