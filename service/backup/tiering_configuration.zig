const ResourceSelection = @import("resource_selection.zig").ResourceSelection;

/// This contains metadata about a tiering configuration.
pub const TieringConfiguration = struct {
    /// The name of the backup vault where the tiering configuration applies.
    /// Use `*` to apply to all backup vaults.
    backup_vault_name: []const u8,

    /// The date and time a tiering configuration was created, in Unix format
    /// and Coordinated Universal Time (UTC). The value of `CreationTime`
    /// is accurate to milliseconds. For example, the value 1516925490.087
    /// represents
    /// Friday, January 26, 2018 12:11:30.087AM.
    creation_time: ?i64,

    /// This is a unique string that identifies the request and
    /// allows failed requests to be retried without the risk of running
    /// the operation twice.
    creator_request_id: ?[]const u8,

    /// The date and time a tiering configuration was updated, in Unix format
    /// and Coordinated Universal Time (UTC). The value of `LastUpdatedTime`
    /// is accurate to milliseconds. For example, the value 1516925490.087
    /// represents
    /// Friday, January 26, 2018 12:11:30.087AM.
    last_updated_time: ?i64,

    /// An array of resource selection objects that specify which resources
    /// are included in the tiering configuration and their tiering settings.
    resource_selection: []const ResourceSelection,

    /// An Amazon Resource Name (ARN) that uniquely identifies the
    /// tiering configuration.
    tiering_configuration_arn: ?[]const u8,

    /// The unique name of the tiering configuration. This cannot be changed
    /// after creation, and it must consist of only alphanumeric characters and
    /// underscores.
    tiering_configuration_name: []const u8,

    pub const json_field_names = .{
        .backup_vault_name = "BackupVaultName",
        .creation_time = "CreationTime",
        .creator_request_id = "CreatorRequestId",
        .last_updated_time = "LastUpdatedTime",
        .resource_selection = "ResourceSelection",
        .tiering_configuration_arn = "TieringConfigurationArn",
        .tiering_configuration_name = "TieringConfigurationName",
    };
};
