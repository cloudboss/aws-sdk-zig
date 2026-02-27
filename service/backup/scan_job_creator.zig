/// Contains identifying information about the creation of a scan job, including
/// the backup plan and rule that initiated the scan.
pub const ScanJobCreator = struct {
    /// An Amazon Resource Name (ARN) that uniquely identifies a backup plan; for
    /// example,
    /// `arn:aws:backup:us-east-1:123456789012:plan:8F81F553-3A74-4A3F-B93D-B3360DC80C50`.
    backup_plan_arn: []const u8,

    /// The ID of the backup plan.
    backup_plan_id: []const u8,

    /// Unique, randomly generated, Unicode, UTF-8 encoded strings that are at most
    /// 1,024 bytes
    /// long. Version IDs cannot be edited.
    backup_plan_version: []const u8,

    /// Uniquely identifies the backup rule that initiated the scan job.
    backup_rule_id: []const u8,

    pub const json_field_names = .{
        .backup_plan_arn = "BackupPlanArn",
        .backup_plan_id = "BackupPlanId",
        .backup_plan_version = "BackupPlanVersion",
        .backup_rule_id = "BackupRuleId",
    };
};
