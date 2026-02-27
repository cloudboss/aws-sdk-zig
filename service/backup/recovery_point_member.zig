/// This is a recovery point which is a child (nested) recovery point
/// of a parent (composite) recovery point. These recovery points
/// can be disassociated from their parent (composite) recovery
/// point, in which case they will no longer be a member.
pub const RecoveryPointMember = struct {
    /// The name of the backup vault
    /// (the logical container in which backups are stored).
    backup_vault_name: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the parent (composite)
    /// recovery point.
    recovery_point_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) that uniquely identifies
    /// a saved resource.
    resource_arn: ?[]const u8,

    /// The Amazon Web Services resource type that is saved as
    /// a recovery point.
    resource_type: ?[]const u8,

    pub const json_field_names = .{
        .backup_vault_name = "BackupVaultName",
        .recovery_point_arn = "RecoveryPointArn",
        .resource_arn = "ResourceArn",
        .resource_type = "ResourceType",
    };
};
