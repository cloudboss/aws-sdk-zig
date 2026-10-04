/// The Amazon EMR-managed logging configuration for a session.
pub const SessionManagedLoggingConfiguration = struct {
    /// Whether Amazon EMR-managed logging is enabled for the session.
    enabled: ?bool = null,

    /// The Amazon Resource Name (ARN) of the KMS key used to encrypt the managed
    /// logs.
    encryption_key_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .encryption_key_arn = "EncryptionKeyArn",
    };
};
