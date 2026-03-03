const AwsBackupBackupPlanAdvancedBackupSettingsDetails = @import("aws_backup_backup_plan_advanced_backup_settings_details.zig").AwsBackupBackupPlanAdvancedBackupSettingsDetails;
const AwsBackupBackupPlanRuleDetails = @import("aws_backup_backup_plan_rule_details.zig").AwsBackupBackupPlanRuleDetails;

/// Provides details about an Backup backup plan and an array of `BackupRule`
/// objects, each of which specifies a backup rule.
pub const AwsBackupBackupPlanBackupPlanDetails = struct {
    /// A list of backup options for each resource type.
    advanced_backup_settings: ?[]const AwsBackupBackupPlanAdvancedBackupSettingsDetails = null,

    /// The display name of a backup plan.
    backup_plan_name: ?[]const u8 = null,

    /// An array of `BackupRule` objects, each of which specifies a scheduled task
    /// that is used to back up a selection of resources.
    backup_plan_rule: ?[]const AwsBackupBackupPlanRuleDetails = null,

    pub const json_field_names = .{
        .advanced_backup_settings = "AdvancedBackupSettings",
        .backup_plan_name = "BackupPlanName",
        .backup_plan_rule = "BackupPlanRule",
    };
};
