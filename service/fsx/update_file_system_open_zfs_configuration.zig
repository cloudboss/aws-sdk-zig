const DiskIopsConfiguration = @import("disk_iops_configuration.zig").DiskIopsConfiguration;
const OpenZFSReadCacheConfiguration = @import("open_zfs_read_cache_configuration.zig").OpenZFSReadCacheConfiguration;

/// The configuration updates for an Amazon FSx for OpenZFS file system.
pub const UpdateFileSystemOpenZFSConfiguration = struct {
    /// (Multi-AZ only) A list of IDs of new virtual private cloud (VPC) route
    /// tables
    /// to associate (add) with your Amazon FSx for OpenZFS file system.
    add_route_table_ids: ?[]const []const u8 = null,

    automatic_backup_retention_days: ?i32 = null,

    /// A Boolean value indicating whether tags for the file system should be copied
    /// to
    /// backups. This value defaults to `false`. If it's set to `true`,
    /// all tags for the file system are copied to all automatic and user-initiated
    /// backups
    /// where the user doesn't specify tags. If this value is `true` and you specify
    /// one or more tags, only the specified tags are copied to backups. If you
    /// specify one or
    /// more tags when creating a user-initiated backup, no tags are copied from the
    /// file
    /// system, regardless of this value.
    copy_tags_to_backups: ?bool = null,

    /// A Boolean value indicating whether tags for the volume should be copied to
    /// snapshots.
    /// This value defaults to `false`. If it's set to `true`, all tags
    /// for the volume are copied to snapshots where the user doesn't specify tags.
    /// If this
    /// value is `true` and you specify one or more tags, only the specified tags
    /// are
    /// copied to snapshots. If you specify one or more tags when creating the
    /// snapshot, no tags
    /// are copied from the volume, regardless of this value.
    copy_tags_to_volumes: ?bool = null,

    daily_automatic_backup_start_time: ?[]const u8 = null,

    disk_iops_configuration: ?DiskIopsConfiguration = null,

    /// (Multi-AZ only) Specifies the IPv6 address range in which the endpoints to
    /// access your
    /// file system will be created. By default in the Amazon FSx API and Amazon FSx
    /// console,
    /// Amazon FSx selects an available /118 IP address range for you from one of
    /// the VPC's CIDR ranges.
    /// You can have overlapping endpoint IP addresses for file systems deployed in
    /// the same VPC/route tables,
    /// as long as they don't overlap with any subnet.
    endpoint_ipv_6_address_range: ?[]const u8 = null,

    /// The configuration for the optional provisioned SSD read cache on file
    /// systems that use the Intelligent-Tiering storage class.
    read_cache_configuration: ?OpenZFSReadCacheConfiguration = null,

    /// (Multi-AZ only) A list of IDs of existing virtual private cloud (VPC)
    /// route tables to disassociate (remove) from your Amazon FSx for OpenZFS file
    /// system. You can use
    /// the API operation to retrieve the
    /// list of VPC route table IDs for a file system.
    remove_route_table_ids: ?[]const []const u8 = null,

    /// The throughput of an Amazon FSx for OpenZFS file system, measured in
    /// megabytes per second  (MB/s). Valid values depend on the DeploymentType you
    /// choose, as follows:
    ///
    /// * For `MULTI_AZ_1` and `SINGLE_AZ_2`, valid values are 160, 320, 640,
    /// 1280, 2560, 3840, 5120, 7680, or 10240 MB/s.
    ///
    /// * For `SINGLE_AZ_1`, valid values are 64, 128, 256, 512, 1024, 2048, 3072,
    ///   or 4096 MB/s.
    throughput_capacity: ?i32 = null,

    weekly_maintenance_start_time: ?[]const u8 = null,

    pub const json_field_names = .{
        .add_route_table_ids = "AddRouteTableIds",
        .automatic_backup_retention_days = "AutomaticBackupRetentionDays",
        .copy_tags_to_backups = "CopyTagsToBackups",
        .copy_tags_to_volumes = "CopyTagsToVolumes",
        .daily_automatic_backup_start_time = "DailyAutomaticBackupStartTime",
        .disk_iops_configuration = "DiskIopsConfiguration",
        .endpoint_ipv_6_address_range = "EndpointIpv6AddressRange",
        .read_cache_configuration = "ReadCacheConfiguration",
        .remove_route_table_ids = "RemoveRouteTableIds",
        .throughput_capacity = "ThroughputCapacity",
        .weekly_maintenance_start_time = "WeeklyMaintenanceStartTime",
    };
};
