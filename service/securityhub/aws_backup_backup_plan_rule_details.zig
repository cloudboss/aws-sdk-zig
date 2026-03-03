const AwsBackupBackupPlanRuleCopyActionsDetails = @import("aws_backup_backup_plan_rule_copy_actions_details.zig").AwsBackupBackupPlanRuleCopyActionsDetails;
const AwsBackupBackupPlanLifecycleDetails = @import("aws_backup_backup_plan_lifecycle_details.zig").AwsBackupBackupPlanLifecycleDetails;

/// Provides details about an array of `BackupRule` objects, each of which
/// specifies a scheduled task that is used to back up a selection of resources.
pub const AwsBackupBackupPlanRuleDetails = struct {
    /// A value in minutes after a backup job is successfully started before it must
    /// be completed, or it is canceled by Backup.
    completion_window_minutes: ?i64 = null,

    /// An array of `CopyAction` objects, each of which contains details of the
    /// copy operation.
    copy_actions: ?[]const AwsBackupBackupPlanRuleCopyActionsDetails = null,

    /// Specifies whether Backup creates continuous backups capable of point-in-time
    /// restore (PITR).
    enable_continuous_backup: ?bool = null,

    /// Defines when a protected resource is transitioned to cold storage and when
    /// it expires. Backup transitions and expires backups automatically according
    /// to the lifecycle that you define. If you don't specify a lifecycle, Backup
    /// applies the lifecycle policy of the source backup to the destination backup.
    ///
    /// Backups transitioned to cold storage must be stored in cold storage for a
    /// minimum of 90 days.
    lifecycle: ?AwsBackupBackupPlanLifecycleDetails = null,

    /// Uniquely identifies a rule that is used to schedule the backup of a
    /// selection of resources.
    rule_id: ?[]const u8 = null,

    /// A display name for a backup rule. Must contain 1 to 50 alphanumeric or '-_.'
    /// characters.
    rule_name: ?[]const u8 = null,

    /// A cron expression in UTC specifying when Backup initiates a backup job.
    schedule_expression: ?[]const u8 = null,

    /// A value in minutes after a backup is scheduled before a job will be canceled
    /// if it doesn't start successfully.
    start_window_minutes: ?i64 = null,

    /// The name of a logical container where backups are stored. Backup vaults are
    /// identified by names that are unique to the Amazon Web Services account used
    /// to create them and the Amazon Web Services Region where they are created.
    /// They consist of letters, numbers, and hyphens.
    target_backup_vault: ?[]const u8 = null,

    pub const json_field_names = .{
        .completion_window_minutes = "CompletionWindowMinutes",
        .copy_actions = "CopyActions",
        .enable_continuous_backup = "EnableContinuousBackup",
        .lifecycle = "Lifecycle",
        .rule_id = "RuleId",
        .rule_name = "RuleName",
        .schedule_expression = "ScheduleExpression",
        .start_window_minutes = "StartWindowMinutes",
        .target_backup_vault = "TargetBackupVault",
    };
};
