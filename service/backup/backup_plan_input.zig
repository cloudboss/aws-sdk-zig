const AdvancedBackupSetting = @import("advanced_backup_setting.zig").AdvancedBackupSetting;
const BackupRuleInput = @import("backup_rule_input.zig").BackupRuleInput;
const ScanSetting = @import("scan_setting.zig").ScanSetting;

/// Contains an optional backup plan display name and an array of `BackupRule`
/// objects, each of which specifies a backup rule. Each rule in a backup plan
/// is a separate
/// scheduled task.
pub const BackupPlanInput = struct {
    /// Specifies a list of `BackupOptions` for each resource type. These settings
    /// are only available for Windows Volume Shadow Copy Service (VSS) backup jobs.
    advanced_backup_settings: ?[]const AdvancedBackupSetting,

    /// The display name of a backup plan. Must contain 1 to 50 alphanumeric or
    /// '-_.'
    /// characters.
    backup_plan_name: []const u8,

    /// An array of `BackupRule` objects, each of which specifies a scheduled task
    /// that is used to back up a selection of resources.
    rules: []const BackupRuleInput,

    /// Contains your scanning configuration for the backup rule and includes the
    /// malware scanner, and scan mode of either full or incremental.
    scan_settings: ?[]const ScanSetting,

    pub const json_field_names = .{
        .advanced_backup_settings = "AdvancedBackupSettings",
        .backup_plan_name = "BackupPlanName",
        .rules = "Rules",
        .scan_settings = "ScanSettings",
    };
};
