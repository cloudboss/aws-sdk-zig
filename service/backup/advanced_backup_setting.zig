const aws = @import("aws");

/// The backup options for each resource type.
pub const AdvancedBackupSetting = struct {
    /// Specifies the backup option for a selected resource. This option is
    /// available for
    /// Windows VSS backup jobs and S3 backups.
    ///
    /// Valid values:
    ///
    /// Set to `"WindowsVSS":"enabled"` to enable the `WindowsVSS` backup
    /// option and create a Windows VSS backup.
    ///
    /// Set to `"WindowsVSS":"disabled"` to create a regular backup. The
    /// `WindowsVSS` option is not enabled by default.
    ///
    /// For S3 backups, set to `"S3BackupACLs":"disabled"` to exclude ACLs from the
    /// backup,
    /// or `"S3BackupObjectTags":"disabled"` to exclude object tags from the backup.
    /// By default, both ACLs and object tags are included in S3 backups.
    ///
    /// If you specify an invalid option, you get an
    /// `InvalidParameterValueException`
    /// exception.
    ///
    /// For more information about Windows VSS backups, see [Creating a VSS-Enabled
    /// Windows
    /// Backup](https://docs.aws.amazon.com/aws-backup/latest/devguide/windows-backups.html).
    backup_options: ?[]const aws.map.StringMapEntry,

    /// Specifies an object containing resource type and backup options. The only
    /// supported
    /// resource type is Amazon EC2 instances with Windows Volume Shadow Copy
    /// Service
    /// (VSS). For a CloudFormation example, see the [sample
    /// CloudFormation template to enable Windows
    /// VSS](https://docs.aws.amazon.com/aws-backup/latest/devguide/integrate-cloudformation-with-aws-backup.html) in the *Backup User Guide*.
    ///
    /// Valid values: `EC2`.
    resource_type: ?[]const u8,

    pub const json_field_names = .{
        .backup_options = "BackupOptions",
        .resource_type = "ResourceType",
    };
};
