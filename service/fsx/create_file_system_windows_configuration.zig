const WindowsAuditLogCreateConfiguration = @import("windows_audit_log_create_configuration.zig").WindowsAuditLogCreateConfiguration;
const WindowsDeploymentType = @import("windows_deployment_type.zig").WindowsDeploymentType;
const DiskIopsConfiguration = @import("disk_iops_configuration.zig").DiskIopsConfiguration;
const WindowsFsrmConfiguration = @import("windows_fsrm_configuration.zig").WindowsFsrmConfiguration;
const SelfManagedActiveDirectoryConfiguration = @import("self_managed_active_directory_configuration.zig").SelfManagedActiveDirectoryConfiguration;

/// The configuration object for the Microsoft Windows file system used in
/// `CreateFileSystem` and `CreateFileSystemFromBackup`
/// operations.
pub const CreateFileSystemWindowsConfiguration = struct {
    /// The ID for an existing Amazon Web Services Managed Microsoft Active
    /// Directory (AD) instance that the
    /// file system should join when it's created.
    active_directory_id: ?[]const u8 = null,

    /// An array of one or more DNS alias names that you want to associate with the
    /// Amazon FSx file system.
    /// Aliases allow you to use existing DNS names to access the data in your
    /// Amazon FSx file system.
    /// You can associate up to 50 aliases with a file system at any time.
    /// You can associate additional DNS aliases after you create the file system
    /// using the AssociateFileSystemAliases operation.
    /// You can remove DNS aliases from the file system after it is created using
    /// the DisassociateFileSystemAliases operation.
    /// You only need to specify the alias name in the request payload.
    /// For more information, see [Managing DNS
    /// aliases](https://docs.aws.amazon.com/fsx/latest/WindowsGuide/managing-dns-aliases.html) and
    /// [Accessing data using DNS
    /// aliases](https://docs.aws.amazon.com/fsx/latest/WindowsGuide/dns-aliases.html).
    ///
    /// An alias name has to meet the following requirements:
    ///
    /// * Formatted as a fully-qualified domain name (FQDN), `hostname.domain`, for
    ///   example, `accounting.example.com`.
    ///
    /// * Can contain alphanumeric characters, the underscore (_), and the hyphen
    ///   (-).
    ///
    /// * Cannot start or end with a hyphen.
    ///
    /// * Can start with a numeric.
    ///
    /// For DNS alias names, Amazon FSx stores alphabetic characters as lowercase
    /// letters (a-z), regardless of how you specify them:
    /// as uppercase letters, lowercase letters, or the corresponding letters in
    /// escape codes.
    aliases: ?[]const []const u8 = null,

    /// The configuration that Amazon FSx for Windows File Server uses to audit and
    /// log
    /// user accesses of files, folders, and file shares on the Amazon FSx for
    /// Windows File Server
    /// file system.
    audit_log_configuration: ?WindowsAuditLogCreateConfiguration = null,

    /// The number of days to retain automatic backups. Setting this property to
    /// `0` disables automatic backups. You can retain automatic backups for a
    /// maximum of 90 days. The default is `30`.
    automatic_backup_retention_days: ?i32 = null,

    /// A boolean flag indicating whether tags for the file system should be copied
    /// to
    /// backups. This value defaults to false. If it's set to true, all tags for the
    /// file
    /// system are copied to all automatic and user-initiated backups where the user
    /// doesn't specify tags. If this value is true, and you specify one or more
    /// tags, only
    /// the specified tags are copied to backups. If you specify one or more tags
    /// when creating a
    /// user-initiated backup, no tags are copied from the file system, regardless
    /// of this value.
    copy_tags_to_backups: ?bool = null,

    /// The preferred time to take daily automatic backups, formatted HH:MM in the
    /// UTC time
    /// zone.
    daily_automatic_backup_start_time: ?[]const u8 = null,

    /// Specifies the file system deployment type, valid values are the following:
    ///
    /// * `MULTI_AZ_1` - Deploys a high availability file system that is configured
    /// for Multi-AZ redundancy to tolerate temporary Availability Zone (AZ)
    /// unavailability. You
    /// can only deploy a Multi-AZ file system in Amazon Web Services Regions that
    /// have a minimum of three Availability Zones. Also
    /// supports HDD storage type
    ///
    /// * `SINGLE_AZ_1` - (Default) Choose to deploy a file system that is
    ///   configured for single AZ redundancy.
    ///
    /// * `SINGLE_AZ_2` - The latest generation Single AZ file system.
    /// Specifies a file system that is configured for single AZ redundancy and
    /// supports HDD storage type.
    ///
    /// For more information, see
    /// [
    /// Availability and Durability: Single-AZ and Multi-AZ File
    /// Systems](https://docs.aws.amazon.com/fsx/latest/WindowsGuide/high-availability-multiAZ.html).
    deployment_type: ?WindowsDeploymentType = null,

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

    /// Required when `DeploymentType` is set to `MULTI_AZ_1`. This specifies the
    /// subnet
    /// in which you want the preferred file server to be located. For in-Amazon Web
    /// Services applications, we recommend that you launch
    /// your clients in the same Availability Zone (AZ) as your preferred file
    /// server to reduce cross-AZ
    /// data transfer costs and minimize latency.
    preferred_subnet_id: ?[]const u8 = null,

    self_managed_active_directory_configuration: ?SelfManagedActiveDirectoryConfiguration = null,

    /// Sets the throughput capacity of an Amazon FSx file system, measured in
    /// megabytes per second (MB/s), in 2 to
    /// the *n*th increments, between 2^3 (8) and 2^11 (2048).
    throughput_capacity: i32,

    /// The preferred start time to perform weekly maintenance, formatted d:HH:MM in
    /// the UTC
    /// time zone, where d is the weekday number, from 1 through 7, beginning with
    /// Monday and ending with Sunday.
    weekly_maintenance_start_time: ?[]const u8 = null,

    pub const json_field_names = .{
        .active_directory_id = "ActiveDirectoryId",
        .aliases = "Aliases",
        .audit_log_configuration = "AuditLogConfiguration",
        .automatic_backup_retention_days = "AutomaticBackupRetentionDays",
        .copy_tags_to_backups = "CopyTagsToBackups",
        .daily_automatic_backup_start_time = "DailyAutomaticBackupStartTime",
        .deployment_type = "DeploymentType",
        .disk_iops_configuration = "DiskIopsConfiguration",
        .fsrm_configuration = "FsrmConfiguration",
        .preferred_subnet_id = "PreferredSubnetId",
        .self_managed_active_directory_configuration = "SelfManagedActiveDirectoryConfiguration",
        .throughput_capacity = "ThroughputCapacity",
        .weekly_maintenance_start_time = "WeeklyMaintenanceStartTime",
    };
};
