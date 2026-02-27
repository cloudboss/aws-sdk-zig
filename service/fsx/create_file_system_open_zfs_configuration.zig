const OpenZFSDeploymentType = @import("open_zfs_deployment_type.zig").OpenZFSDeploymentType;
const DiskIopsConfiguration = @import("disk_iops_configuration.zig").DiskIopsConfiguration;
const OpenZFSReadCacheConfiguration = @import("open_zfs_read_cache_configuration.zig").OpenZFSReadCacheConfiguration;
const OpenZFSCreateRootVolumeConfiguration = @import("open_zfs_create_root_volume_configuration.zig").OpenZFSCreateRootVolumeConfiguration;

/// The Amazon FSx for OpenZFS configuration properties for the file system that
/// you are creating.
pub const CreateFileSystemOpenZFSConfiguration = struct {
    automatic_backup_retention_days: ?i32,

    /// A Boolean value indicating whether tags for the file system should be copied
    /// to
    /// backups. This value defaults to `false`. If it's set to `true`,
    /// all tags for the file system are copied to all automatic and user-initiated
    /// backups
    /// where the user doesn't specify tags. If this value is `true`, and you
    /// specify
    /// one or more tags, only the specified tags are copied to backups. If you
    /// specify one or
    /// more tags when creating a user-initiated backup, no tags are copied from the
    /// file
    /// system, regardless of this value.
    copy_tags_to_backups: ?bool,

    /// A Boolean value indicating whether tags for the file system should be copied
    /// to volumes.
    /// This value defaults to `false`. If it's set to `true`, all tags
    /// for the file system are copied to volumes where the user doesn't specify
    /// tags. If this
    /// value is `true`, and you specify one or more tags, only the specified tags
    /// are copied to volumes. If you specify one or more tags when creating the
    /// volume, no
    /// tags are copied from the file system, regardless of this value.
    copy_tags_to_volumes: ?bool,

    daily_automatic_backup_start_time: ?[]const u8,

    /// Specifies the file system deployment type. Valid values are the following:
    ///
    /// * `MULTI_AZ_1`- Creates file systems with high availability and durability
    ///   by replicating your data and supporting failover across multiple
    ///   Availability Zones in the same Amazon Web Services Region.
    ///
    /// * `SINGLE_AZ_HA_2`- Creates file systems with high availability and
    ///   throughput capacities of 160 - 10,240 MB/s using an NVMe L2ARC cache by
    ///   deploying a primary and standby file system within the same Availability
    ///   Zone.
    ///
    /// * `SINGLE_AZ_HA_1`- Creates file systems with high availability and
    ///   throughput capacities of 64 - 4,096 MB/s by deploying a primary and
    ///   standby file system within the same Availability Zone.
    ///
    /// * `SINGLE_AZ_2`- Creates file systems with throughput capacities of 160 -
    ///   10,240 MB/s
    /// using an NVMe L2ARC cache that automatically recover within a single
    /// Availability Zone.
    ///
    /// * `SINGLE_AZ_1`- Creates file systems with throughput capacities of 64 -
    ///   4,096 MBs that automatically recover within a single Availability Zone.
    ///
    /// For a list of which Amazon Web Services Regions each deployment type is
    /// available in, see [Deployment type
    /// availability](https://docs.aws.amazon.com/fsx/latest/OpenZFSGuide/availability-durability.html#available-aws-regions).
    /// For more information on the differences in performance between deployment
    /// types, see [File system
    /// performance](https://docs.aws.amazon.com/fsx/latest/OpenZFSGuide/performance.html#zfs-fs-performance)
    /// in the *Amazon FSx for OpenZFS User Guide*.
    deployment_type: OpenZFSDeploymentType,

    disk_iops_configuration: ?DiskIopsConfiguration,

    /// (Multi-AZ only) Specifies the IPv4 address range in which the endpoints to
    /// access your
    /// file system will be created. By default in the Amazon FSx API and Amazon FSx
    /// console, Amazon FSx
    /// selects an available /28 IP address range for you from one of the VPC's CIDR
    /// ranges.
    /// You can have overlapping endpoint IP addresses for file systems deployed in
    /// the
    /// same VPC/route tables, as long as they don't overlap with any subnet.
    endpoint_ip_address_range: ?[]const u8,

    /// (Multi-AZ only) Specifies the IPv6 address range in which the endpoints to
    /// access
    /// your file system will be created. By default in the Amazon FSx API and
    /// Amazon FSx console, Amazon FSx selects an available /118 IP address
    /// range for you from one of the VPC's CIDR ranges. You can have overlapping
    /// endpoint
    /// IP addresses for file systems deployed in the same VPC/route tables, as long
    /// as they
    /// don't overlap with any subnet.
    endpoint_ipv_6_address_range: ?[]const u8,

    /// Required when `DeploymentType` is set to `MULTI_AZ_1`. This specifies the
    /// subnet in which you want the preferred file server to be located.
    preferred_subnet_id: ?[]const u8,

    /// Specifies the optional provisioned SSD read cache on file systems that use
    /// the Intelligent-Tiering storage class.
    read_cache_configuration: ?OpenZFSReadCacheConfiguration,

    /// The configuration Amazon FSx uses when creating the root value of the Amazon
    /// FSx for OpenZFS
    /// file system. All volumes are children of the root volume.
    root_volume_configuration: ?OpenZFSCreateRootVolumeConfiguration,

    /// (Multi-AZ only) Specifies the route tables in which Amazon FSx creates the
    /// rules
    /// for routing traffic to the correct file server. You should specify all
    /// virtual private cloud
    /// (VPC) route tables associated with the subnets in which your clients are
    /// located. By default,
    /// Amazon FSx selects your VPC's default route table.
    route_table_ids: ?[]const []const u8,

    /// Specifies the throughput of an Amazon FSx for OpenZFS file system, measured
    /// in megabytes per second (MBps). Valid values depend on the `DeploymentType`
    /// that you choose, as follows:
    ///
    /// * For `MULTI_AZ_1` and `SINGLE_AZ_2`, valid values are 160, 320, 640,
    /// 1280, 2560, 3840, 5120, 7680, or 10240 MBps.
    ///
    /// * For `SINGLE_AZ_1`, valid values are 64, 128, 256, 512, 1024, 2048, 3072,
    ///   or 4096 MBps.
    ///
    /// You pay for additional throughput capacity that you provision.
    throughput_capacity: i32,

    weekly_maintenance_start_time: ?[]const u8,

    pub const json_field_names = .{
        .automatic_backup_retention_days = "AutomaticBackupRetentionDays",
        .copy_tags_to_backups = "CopyTagsToBackups",
        .copy_tags_to_volumes = "CopyTagsToVolumes",
        .daily_automatic_backup_start_time = "DailyAutomaticBackupStartTime",
        .deployment_type = "DeploymentType",
        .disk_iops_configuration = "DiskIopsConfiguration",
        .endpoint_ip_address_range = "EndpointIpAddressRange",
        .endpoint_ipv_6_address_range = "EndpointIpv6AddressRange",
        .preferred_subnet_id = "PreferredSubnetId",
        .read_cache_configuration = "ReadCacheConfiguration",
        .root_volume_configuration = "RootVolumeConfiguration",
        .route_table_ids = "RouteTableIds",
        .throughput_capacity = "ThroughputCapacity",
        .weekly_maintenance_start_time = "WeeklyMaintenanceStartTime",
    };
};
