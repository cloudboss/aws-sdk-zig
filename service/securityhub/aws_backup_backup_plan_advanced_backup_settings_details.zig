const aws = @import("aws");

/// Provides a list of backup options for each resource type.
pub const AwsBackupBackupPlanAdvancedBackupSettingsDetails = struct {
    /// Specifies the backup option for a selected resource. This option is only
    /// available for Windows
    /// Volume Shadow Copy Service (VSS) backup jobs. Valid values are as follows:
    ///
    /// * Set to `WindowsVSS: enabled` to enable the WindowsVSS backup option and
    ///   create a Windows VSS backup.
    ///
    /// * Set to `WindowsVSS: disabled` to create a regular backup. The `WindowsVSS`
    ///   option is not enabled by default.
    backup_options: ?[]const aws.map.StringMapEntry,

    /// The name of a resource type. The only supported resource type is Amazon EC2
    /// instances with Windows VSS.
    ///
    /// The only valid value is `EC2`.
    resource_type: ?[]const u8,

    pub const json_field_names = .{
        .backup_options = "BackupOptions",
        .resource_type = "ResourceType",
    };
};
