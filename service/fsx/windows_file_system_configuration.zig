const Alias = @import("alias.zig").Alias;
const WindowsAuditLogConfiguration = @import("windows_audit_log_configuration.zig").WindowsAuditLogConfiguration;
const WindowsDeploymentType = @import("windows_deployment_type.zig").WindowsDeploymentType;
const DiskIopsConfiguration = @import("disk_iops_configuration.zig").DiskIopsConfiguration;
const WindowsFsrmConfiguration = @import("windows_fsrm_configuration.zig").WindowsFsrmConfiguration;
const FileSystemMaintenanceOperation = @import("file_system_maintenance_operation.zig").FileSystemMaintenanceOperation;
const SelfManagedActiveDirectoryAttributes = @import("self_managed_active_directory_attributes.zig").SelfManagedActiveDirectoryAttributes;

/// The configuration for this Microsoft Windows file system.
pub const WindowsFileSystemConfiguration = struct {
    /// The ID for an existing Amazon Web Services Managed Microsoft Active
    /// Directory instance that the file system is joined to.
    active_directory_id: ?[]const u8,

    aliases: ?[]const Alias,

    /// The configuration that Amazon FSx for Windows File Server uses to audit and
    /// log
    /// user accesses of files, folders, and file shares on the Amazon FSx for
    /// Windows File Server
    /// file system.
    audit_log_configuration: ?WindowsAuditLogConfiguration,

    /// The number of days to retain automatic backups. Setting this to 0 disables
    /// automatic
    /// backups. You can retain automatic backups for a maximum of 90 days.
    automatic_backup_retention_days: ?i32,

    /// A boolean flag indicating whether tags on the file system should be copied
    /// to backups.
    /// This value defaults to false. If it's set to true, all tags on the file
    /// system are
    /// copied to all automatic backups and any user-initiated backups where the
    /// user
    /// doesn't specify any tags. If this value is true, and you specify one or more
    /// tags,
    /// only the specified tags are copied to backups. If you specify one or more
    /// tags when
    /// creating a user-initiated backup, no tags are copied from the file system,
    /// regardless of this value.
    copy_tags_to_backups: ?bool,

    /// The preferred time to take daily automatic backups, in the UTC time zone.
    daily_automatic_backup_start_time: ?[]const u8,

    /// Specifies the file system deployment type, valid values are the following:
    ///
    /// * `MULTI_AZ_1` - Specifies a high availability file system that is
    ///   configured for Multi-AZ
    /// redundancy to tolerate temporary Availability Zone (AZ) unavailability, and
    /// supports SSD and HDD storage.
    ///
    /// * `SINGLE_AZ_1` - (Default) Specifies a file system that is configured for
    ///   single AZ redundancy,
    /// only supports SSD storage.
    ///
    /// * `SINGLE_AZ_2` - Latest generation Single AZ file system.
    /// Specifies a file system that is configured for single AZ redundancy and
    /// supports SSD and HDD storage.
    ///
    /// For more information, see
    /// [Single-AZ and Multi-AZ File
    /// Systems](https://docs.aws.amazon.com/fsx/latest/WindowsGuide/high-availability-multiAZ.html).
    deployment_type: ?WindowsDeploymentType,

    /// The SSD IOPS (input/output operations per second) configuration for an
    /// Amazon FSx for Windows file system.
    /// By default, Amazon FSx automatically provisions 3 IOPS per GiB of storage
    /// capacity. You can provision additional
    /// IOPS per GiB of storage, up to the maximum limit associated with your chosen
    /// throughput capacity.
    disk_iops_configuration: ?DiskIopsConfiguration,

    /// The File Server Resource Manager (FSRM) configuration that Amazon FSx for
    /// Windows File Server uses for the file system. FSRM is disabled by default.
    fsrm_configuration: ?WindowsFsrmConfiguration,

    /// The list of maintenance operations in progress for this file system.
    maintenance_operations_in_progress: ?[]const FileSystemMaintenanceOperation,

    /// For `MULTI_AZ_1` deployment types, the IPv4 address of the primary, or
    /// preferred, file server.
    ///
    /// Use this IP address when mounting the file system on Linux SMB clients or
    /// Windows SMB clients that
    /// are not joined to a Microsoft Active Directory.
    /// Applicable for all Windows file system deployment types.
    /// This IPv4 address is temporarily unavailable
    /// when the file system is undergoing maintenance. For Linux and Windows
    /// SMB clients that are joined to an Active Directory, use the file system's
    /// DNSName instead. For more information
    /// on mapping and mounting file shares, see
    /// [Accessing data using file
    /// shares](https://docs.aws.amazon.com/fsx/latest/WindowsGuide/using-file-shares.html).
    preferred_file_server_ip: ?[]const u8,

    /// For MULTI_AZ_1 deployment types, the IPv6 address of the primary, or
    /// preferred, file server.
    /// Use this IP address when mounting the file system on Linux SMB clients or
    /// Windows SMB clients
    /// that are not joined to a Microsoft Active Directory. Applicable for all
    /// Windows file system
    /// deployment types. This IPv6 address is temporarily unavailable when the file
    /// system is undergoing
    /// maintenance. For Linux and Windows SMB clients that are joined to an Active
    /// Directory, use the
    /// file system's DNSName instead.
    preferred_file_server_ipv_6: ?[]const u8,

    /// For `MULTI_AZ_1` deployment types, it specifies the ID of the subnet where
    /// the preferred file server is located.
    /// Must be one of the two subnet IDs specified in `SubnetIds` property.
    /// Amazon FSx serves traffic from this subnet except in the event of a failover
    /// to the secondary file server.
    ///
    /// For `SINGLE_AZ_1` and `SINGLE_AZ_2` deployment types, this value is the same
    /// as that for `SubnetIDs`.
    /// For more information, see
    /// [Availability and durability: Single-AZ and Multi-AZ file
    /// systems](https://docs.aws.amazon.com/fsx/latest/WindowsGuide/high-availability-multiAZ.html#single-multi-az-resources).
    preferred_subnet_id: ?[]const u8,

    /// For `MULTI_AZ_1` deployment types, use this endpoint when performing
    /// administrative tasks on the file system using
    /// Amazon FSx Remote PowerShell.
    ///
    /// For `SINGLE_AZ_1` and `SINGLE_AZ_2` deployment types, this is the DNS name
    /// of the file system.
    ///
    /// This endpoint is temporarily unavailable when the file system is undergoing
    /// maintenance.
    remote_administration_endpoint: ?[]const u8,

    self_managed_active_directory_configuration: ?SelfManagedActiveDirectoryAttributes,

    /// The throughput of the Amazon FSx file system, measured in megabytes per
    /// second.
    throughput_capacity: ?i32,

    /// The preferred start time to perform weekly maintenance, formatted d:HH:MM in
    /// the UTC
    /// time zone. d is the weekday number, from 1 through 7, beginning with Monday
    /// and ending with Sunday.
    weekly_maintenance_start_time: ?[]const u8,

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
        .maintenance_operations_in_progress = "MaintenanceOperationsInProgress",
        .preferred_file_server_ip = "PreferredFileServerIp",
        .preferred_file_server_ipv_6 = "PreferredFileServerIpv6",
        .preferred_subnet_id = "PreferredSubnetId",
        .remote_administration_endpoint = "RemoteAdministrationEndpoint",
        .self_managed_active_directory_configuration = "SelfManagedActiveDirectoryConfiguration",
        .throughput_capacity = "ThroughputCapacity",
        .weekly_maintenance_start_time = "WeeklyMaintenanceStartTime",
    };
};
