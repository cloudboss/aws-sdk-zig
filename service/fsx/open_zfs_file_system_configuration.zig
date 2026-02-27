const OpenZFSDeploymentType = @import("open_zfs_deployment_type.zig").OpenZFSDeploymentType;
const DiskIopsConfiguration = @import("disk_iops_configuration.zig").DiskIopsConfiguration;
const OpenZFSReadCacheConfiguration = @import("open_zfs_read_cache_configuration.zig").OpenZFSReadCacheConfiguration;

/// The configuration for the Amazon FSx for OpenZFS file system.
pub const OpenZFSFileSystemConfiguration = struct {
    automatic_backup_retention_days: ?i32,

    /// A Boolean value indicating whether tags on the file system should be copied
    /// to
    /// backups.
    /// If it's set to `true`, all tags on the file system are copied to all
    /// automatic backups and any user-initiated backups where the user doesn't
    /// specify any
    /// tags. If this value is `true` and you specify one or more tags, only the
    /// specified tags are copied to backups. If you specify one or more tags when
    /// creating a
    /// user-initiated backup, no tags are copied from the file system, regardless
    /// of this
    /// value.
    copy_tags_to_backups: ?bool,

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
    copy_tags_to_volumes: ?bool,

    daily_automatic_backup_start_time: ?[]const u8,

    /// Specifies the file-system deployment type. Amazon FSx for OpenZFS supports 
    /// `MULTI_AZ_1`, `SINGLE_AZ_HA_2`, `SINGLE_AZ_HA_1`, `SINGLE_AZ_2`, and
    /// `SINGLE_AZ_1`.
    deployment_type: ?OpenZFSDeploymentType,

    disk_iops_configuration: ?DiskIopsConfiguration,

    /// The IPv4 address of the endpoint
    /// that is used to access data or to manage the file system.
    endpoint_ip_address: ?[]const u8,

    /// (Multi-AZ only) Specifies the IPv4 address range in which the endpoints to
    /// access your
    /// file system will be created. By default in the Amazon FSx API and Amazon FSx
    /// console, Amazon FSx
    /// selects an available /28 IP address range for you from one of the VPC's CIDR
    /// ranges.
    /// You can have overlapping endpoint IP addresses for file systems deployed in
    /// the
    /// same VPC/route tables.
    endpoint_ip_address_range: ?[]const u8,

    /// The IPv6 address of the endpoint that is used to access data or to manage
    /// the file system.
    endpoint_ipv_6_address: ?[]const u8,

    /// (Multi-AZ only) Specifies the IPv6 address range in which the endpoints to
    /// access your
    /// file system will be created. By default in the Amazon FSx API and Amazon FSx
    /// console, Amazon FSx selects an available /118 IP address range for you from
    /// one of the
    /// VPC's CIDR ranges. You can have overlapping endpoint IP addresses for file
    /// systems deployed
    /// in the same VPC/route tables, as long as they don't overlap with any subnet.
    endpoint_ipv_6_address_range: ?[]const u8,

    /// Required when `DeploymentType` is set to `MULTI_AZ_1`. This
    /// specifies the subnet in which you want the preferred file server to be
    /// located.
    preferred_subnet_id: ?[]const u8,

    /// Required when `StorageType` is set to `INTELLIGENT_TIERING`. Specifies the
    /// optional provisioned SSD read cache.
    read_cache_configuration: ?OpenZFSReadCacheConfiguration,

    /// The ID of the root volume of the OpenZFS file system.
    root_volume_id: ?[]const u8,

    /// (Multi-AZ only) The VPC route tables in which your file system's endpoints
    /// are
    /// created.
    route_table_ids: ?[]const []const u8,

    /// The throughput of an Amazon FSx file system, measured in megabytes per
    /// second (MBps).
    throughput_capacity: ?i32,

    weekly_maintenance_start_time: ?[]const u8,

    pub const json_field_names = .{
        .automatic_backup_retention_days = "AutomaticBackupRetentionDays",
        .copy_tags_to_backups = "CopyTagsToBackups",
        .copy_tags_to_volumes = "CopyTagsToVolumes",
        .daily_automatic_backup_start_time = "DailyAutomaticBackupStartTime",
        .deployment_type = "DeploymentType",
        .disk_iops_configuration = "DiskIopsConfiguration",
        .endpoint_ip_address = "EndpointIpAddress",
        .endpoint_ip_address_range = "EndpointIpAddressRange",
        .endpoint_ipv_6_address = "EndpointIpv6Address",
        .endpoint_ipv_6_address_range = "EndpointIpv6AddressRange",
        .preferred_subnet_id = "PreferredSubnetId",
        .read_cache_configuration = "ReadCacheConfiguration",
        .root_volume_id = "RootVolumeId",
        .route_table_ids = "RouteTableIds",
        .throughput_capacity = "ThroughputCapacity",
        .weekly_maintenance_start_time = "WeeklyMaintenanceStartTime",
    };
};
