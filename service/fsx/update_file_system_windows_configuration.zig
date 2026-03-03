const WindowsAuditLogCreateConfiguration = @import("windows_audit_log_create_configuration.zig").WindowsAuditLogCreateConfiguration;
const DiskIopsConfiguration = @import("disk_iops_configuration.zig").DiskIopsConfiguration;
const WindowsFsrmConfiguration = @import("windows_fsrm_configuration.zig").WindowsFsrmConfiguration;
const SelfManagedActiveDirectoryConfigurationUpdates = @import("self_managed_active_directory_configuration_updates.zig").SelfManagedActiveDirectoryConfigurationUpdates;

/// Updates the configuration for an existing Amazon FSx for Windows
/// File Server file system. Amazon FSx only overwrites existing properties with
/// non-null values
/// provided in the request.
pub const UpdateFileSystemWindowsConfiguration = struct {
    /// The configuration that Amazon FSx for Windows File Server uses to audit and
    /// log
    /// user accesses of files, folders, and file shares on the Amazon FSx for
    /// Windows File Server
    /// file system..
    audit_log_configuration: ?WindowsAuditLogCreateConfiguration = null,

    /// The number of days to retain automatic backups. Setting this property to
    /// `0` disables automatic backups. You can retain automatic backups for a
    /// maximum of 90 days. The default is `30`. For more information, see
    /// [Working with Automatic Daily
    /// Backups](https://docs.aws.amazon.com/fsx/latest/WindowsGuide/using-backups.html#automatic-backups).
    automatic_backup_retention_days: ?i32 = null,

    /// The preferred time to start the daily automatic backup, in the UTC time
    /// zone, for example, `02:00`
    daily_automatic_backup_start_time: ?[]const u8 = null,

    /// The SSD IOPS (input/output operations per second) configuration for an
    /// Amazon FSx for Windows file system.
    /// By default, Amazon FSx automatically provisions 3 IOPS per GiB of storage
    /// capacity. You can provision additional
    /// IOPS per GiB of storage, up to the maximum limit associated with your chosen
    /// throughput capacity.
    disk_iops_configuration: ?DiskIopsConfiguration = null,

    /// The File Server Resource Manager (FSRM) configuration that Amazon FSx for
    /// Windows File Server uses for the file system. FSRM is disabled by default.
    fsrm_configuration: ?WindowsFsrmConfiguration = null,

    /// The configuration Amazon FSx uses to join the Windows File Server instance
    /// to the
    /// self-managed Microsoft AD directory. You cannot make a self-managed
    /// Microsoft AD update request if there is an existing self-managed Microsoft
    /// AD update request in progress.
    self_managed_active_directory_configuration: ?SelfManagedActiveDirectoryConfigurationUpdates = null,

    /// Sets the target value for a file system's throughput capacity, in MB/s, that
    /// you are updating the file system to. Valid values are
    /// 8, 16, 32, 64, 128, 256, 512, 1024, 2048. You cannot make a throughput
    /// capacity update request if there is an existing throughput capacity update
    /// request in progress. For more information,
    /// see [Managing Throughput
    /// Capacity](https://docs.aws.amazon.com/fsx/latest/WindowsGuide/managing-throughput-capacity.html).
    throughput_capacity: ?i32 = null,

    /// The preferred start time to perform weekly maintenance, formatted d:HH:MM in
    /// the UTC
    /// time zone. Where d is the weekday number, from 1 through 7, with 1 = Monday
    /// and 7 = Sunday.
    weekly_maintenance_start_time: ?[]const u8 = null,

    pub const json_field_names = .{
        .audit_log_configuration = "AuditLogConfiguration",
        .automatic_backup_retention_days = "AutomaticBackupRetentionDays",
        .daily_automatic_backup_start_time = "DailyAutomaticBackupStartTime",
        .disk_iops_configuration = "DiskIopsConfiguration",
        .fsrm_configuration = "FsrmConfiguration",
        .self_managed_active_directory_configuration = "SelfManagedActiveDirectoryConfiguration",
        .throughput_capacity = "ThroughputCapacity",
        .weekly_maintenance_start_time = "WeeklyMaintenanceStartTime",
    };
};
