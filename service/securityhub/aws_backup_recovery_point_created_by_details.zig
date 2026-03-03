/// Contains information about the backup plan and rule that Backup used to
/// initiate the recovery point backup.
pub const AwsBackupRecoveryPointCreatedByDetails = struct {
    /// An Amazon Resource Name (ARN) that uniquely identifies a backup plan.
    backup_plan_arn: ?[]const u8 = null,

    /// Uniquely identifies a backup plan.
    backup_plan_id: ?[]const u8 = null,

    /// Unique, randomly generated, Unicode, UTF-8 encoded strings that are at most
    /// 1,024 bytes long. Version IDs cannot be edited.
    backup_plan_version: ?[]const u8 = null,

    /// Uniquely identifies a rule used to schedule the backup of a selection of
    /// resources.
    backup_rule_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .backup_plan_arn = "BackupPlanArn",
        .backup_plan_id = "BackupPlanId",
        .backup_plan_version = "BackupPlanVersion",
        .backup_rule_id = "BackupRuleId",
    };
};
