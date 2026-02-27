/// Contains information about the backup plan and rule that Backup used to
/// initiate the recovery point backup.
pub const RecoveryPointCreator = struct {
    /// An Amazon Resource Name (ARN) that uniquely identifies a backup plan; for
    /// example,
    /// `arn:aws:backup:us-east-1:123456789012:plan:8F81F553-3A74-4A3F-B93D-B3360DC80C50`.
    backup_plan_arn: ?[]const u8,

    /// Uniquely identifies a backup plan.
    backup_plan_id: ?[]const u8,

    /// The name of the backup plan that created this recovery point. This provides
    /// human-readable context about which backup plan was responsible for the
    /// backup job.
    backup_plan_name: ?[]const u8,

    /// Version IDs are unique, randomly generated, Unicode, UTF-8 encoded strings
    /// that are at
    /// most 1,024 bytes long. They cannot be edited.
    backup_plan_version: ?[]const u8,

    /// The cron expression that defines the schedule for the backup rule. This
    /// shows the frequency and timing of when backups are automatically triggered.
    backup_rule_cron: ?[]const u8,

    /// Uniquely identifies a rule used to schedule the backup of a selection of
    /// resources.
    backup_rule_id: ?[]const u8,

    /// The name of the backup rule within the backup plan that created this
    /// recovery point. This helps identify which specific rule triggered the backup
    /// job.
    backup_rule_name: ?[]const u8,

    /// The timezone used for the backup rule schedule. This provides context for
    /// when backups are scheduled to run in the specified timezone.
    backup_rule_timezone: ?[]const u8,

    pub const json_field_names = .{
        .backup_plan_arn = "BackupPlanArn",
        .backup_plan_id = "BackupPlanId",
        .backup_plan_name = "BackupPlanName",
        .backup_plan_version = "BackupPlanVersion",
        .backup_rule_cron = "BackupRuleCron",
        .backup_rule_id = "BackupRuleId",
        .backup_rule_name = "BackupRuleName",
        .backup_rule_timezone = "BackupRuleTimezone",
    };
};
