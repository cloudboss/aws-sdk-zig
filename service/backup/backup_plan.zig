const AdvancedBackupSetting = @import("advanced_backup_setting.zig").AdvancedBackupSetting;
const BackupRule = @import("backup_rule.zig").BackupRule;
const ScanSetting = @import("scan_setting.zig").ScanSetting;

/// Contains an optional backup plan display name and an array of `BackupRule`
/// objects, each of which specifies a backup rule. Each rule in a backup plan
/// is a separate
/// scheduled task and can back up a different selection of Amazon Web Services
/// resources.
pub const BackupPlan = struct {
    /// Contains a list of `BackupOptions` for each resource type.
    advanced_backup_settings: ?[]const AdvancedBackupSetting = null,

    /// The display name of a backup plan. Must contain only alphanumeric or '-_.'
    /// special characters.
    ///
    /// If this is set in the console, it can contain 1 to 50 characters; if this
    /// is set through CLI or API, it can contain 1 to 200 characters.
    backup_plan_name: []const u8,

    /// An array of `BackupRule` objects, each of which specifies a scheduled task
    /// that is used to back up a selection of resources.
    rules: []const BackupRule,

    /// Contains your scanning configuration for the backup plan and includes the
    /// Malware scanner, your selected resources, and scanner role.
    scan_settings: ?[]const ScanSetting = null,

    pub const json_field_names = .{
        .advanced_backup_settings = "AdvancedBackupSettings",
        .backup_plan_name = "BackupPlanName",
        .rules = "Rules",
        .scan_settings = "ScanSettings",
    };
};
