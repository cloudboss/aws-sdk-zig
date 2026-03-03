const AwsBackupBackupPlanLifecycleDetails = @import("aws_backup_backup_plan_lifecycle_details.zig").AwsBackupBackupPlanLifecycleDetails;

/// An array of `CopyAction` objects, each of which contains details of the copy
/// operation.
pub const AwsBackupBackupPlanRuleCopyActionsDetails = struct {
    /// An Amazon Resource Name (ARN) that uniquely identifies the destination
    /// backup vault for the copied backup.
    destination_backup_vault_arn: ?[]const u8 = null,

    /// Defines when a protected resource is transitioned to cold storage and when
    /// it expires.
    /// Backup transitions and expires backups automatically according to the
    /// lifecycle that you define. If you don't specify a lifecycle, Backup applies
    /// the lifecycle policy of the source backup to the destination backup.
    ///
    /// Backups transitioned to cold storage must be stored in cold storage for a
    /// minimum of 90 days.
    lifecycle: ?AwsBackupBackupPlanLifecycleDetails = null,

    pub const json_field_names = .{
        .destination_backup_vault_arn = "DestinationBackupVaultArn",
        .lifecycle = "Lifecycle",
    };
};
