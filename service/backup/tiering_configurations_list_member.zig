/// This contains metadata about a tiering configuration returned in a list.
pub const TieringConfigurationsListMember = struct {
    /// The name of the backup vault where the tiering configuration applies.
    /// Use `*` to apply to all backup vaults.
    backup_vault_name: ?[]const u8 = null,

    /// The date and time a tiering configuration was created, in Unix format
    /// and Coordinated Universal Time (UTC). The value of `CreationTime`
    /// is accurate to milliseconds. For example, the value 1516925490.087
    /// represents
    /// Friday, January 26, 2018 12:11:30.087AM.
    creation_time: ?i64 = null,

    /// The date and time a tiering configuration was updated, in Unix format
    /// and Coordinated Universal Time (UTC). The value of `LastUpdatedTime`
    /// is accurate to milliseconds. For example, the value 1516925490.087
    /// represents
    /// Friday, January 26, 2018 12:11:30.087AM.
    last_updated_time: ?i64 = null,

    /// An Amazon Resource Name (ARN) that uniquely identifies the
    /// tiering configuration.
    tiering_configuration_arn: ?[]const u8 = null,

    /// The unique name of the tiering configuration.
    tiering_configuration_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .backup_vault_name = "BackupVaultName",
        .creation_time = "CreationTime",
        .last_updated_time = "LastUpdatedTime",
        .tiering_configuration_arn = "TieringConfigurationArn",
        .tiering_configuration_name = "TieringConfigurationName",
    };
};
