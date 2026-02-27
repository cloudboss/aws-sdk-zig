/// The managed log persistence configuration for a job run.
pub const ManagedPersistenceMonitoringConfiguration = struct {
    /// Enables managed logging and defaults to true. If set to false, managed
    /// logging will be turned off.
    enabled: ?bool,

    /// The KMS key ARN to encrypt the logs stored in managed log persistence.
    encryption_key_arn: ?[]const u8,

    pub const json_field_names = .{
        .enabled = "enabled",
        .encryption_key_arn = "encryptionKeyArn",
    };
};
