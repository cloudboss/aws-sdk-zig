/// Provides information on the specified protect configuration.
pub const ProtectConfigurationInformation = struct {
    /// This is true if the protect configuration is set as your account default
    /// protect configuration.
    account_default: bool = false,

    /// The time when the protect configuration was created, in [UNIX epoch
    /// time](https://www.epochconverter.com/) format.
    created_timestamp: i64,

    /// The status of deletion protection for the protect configuration. When set to
    /// true deletion protection is enabled. By default this is set to false.
    deletion_protection_enabled: bool = false,

    /// The Amazon Resource Name (ARN) of the protect configuration.
    protect_configuration_arn: []const u8,

    /// The unique identifier for the protect configuration.
    protect_configuration_id: []const u8,

    pub const json_field_names = .{
        .account_default = "AccountDefault",
        .created_timestamp = "CreatedTimestamp",
        .deletion_protection_enabled = "DeletionProtectionEnabled",
        .protect_configuration_arn = "ProtectConfigurationArn",
        .protect_configuration_id = "ProtectConfigurationId",
    };
};
