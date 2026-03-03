const DataCompressionType = @import("data_compression_type.zig").DataCompressionType;
const LustreReadCacheConfiguration = @import("lustre_read_cache_configuration.zig").LustreReadCacheConfiguration;
const DataRepositoryConfiguration = @import("data_repository_configuration.zig").DataRepositoryConfiguration;
const LustreDeploymentType = @import("lustre_deployment_type.zig").LustreDeploymentType;
const DriveCacheType = @import("drive_cache_type.zig").DriveCacheType;
const LustreLogConfiguration = @import("lustre_log_configuration.zig").LustreLogConfiguration;
const FileSystemLustreMetadataConfiguration = @import("file_system_lustre_metadata_configuration.zig").FileSystemLustreMetadataConfiguration;
const LustreRootSquashConfiguration = @import("lustre_root_squash_configuration.zig").LustreRootSquashConfiguration;

/// The configuration for the Amazon FSx for Lustre file system.
pub const LustreFileSystemConfiguration = struct {
    automatic_backup_retention_days: ?i32 = null,

    /// A boolean flag indicating whether tags on the file system are copied to
    /// backups.
    /// If it's set to true, all tags on the file system are
    /// copied to all automatic backups and any user-initiated backups where the
    /// user
    /// doesn't specify any tags. If this value is true, and you specify one or more
    /// tags,
    /// only the specified tags are copied to backups. If you specify one or more
    /// tags when
    /// creating a user-initiated backup, no tags are copied from the file system,
    /// regardless of this value. (Default = false)
    copy_tags_to_backups: ?bool = null,

    daily_automatic_backup_start_time: ?[]const u8 = null,

    /// The data compression configuration for the file system.
    /// `DataCompressionType`
    /// can have the following values:
    ///
    /// * `NONE` - Data compression is turned off for
    /// the file system.
    ///
    /// * `LZ4` - Data compression is turned on with the LZ4
    /// algorithm.
    ///
    /// For more information, see [Lustre data
    /// compression](https://docs.aws.amazon.com/fsx/latest/LustreGuide/data-compression.html).
    data_compression_type: ?DataCompressionType = null,

    /// Required when `StorageType` is set to `INTELLIGENT_TIERING`.
    /// Specifies the optional provisioned SSD read cache.
    data_read_cache_configuration: ?LustreReadCacheConfiguration = null,

    data_repository_configuration: ?DataRepositoryConfiguration = null,

    /// The deployment type of the FSx for Lustre file system.
    /// *Scratch deployment type* is designed for temporary storage
    /// and shorter-term processing of data.
    ///
    /// `SCRATCH_1` and `SCRATCH_2` deployment types are best suited
    /// for when you need temporary storage and shorter-term processing of data. The
    /// `SCRATCH_2` deployment type provides in-transit encryption of data and
    /// higher burst
    /// throughput capacity than `SCRATCH_1`.
    ///
    /// The `PERSISTENT_1` and `PERSISTENT_2` deployment type is used
    /// for longer-term storage and workloads and encryption of data in transit.
    /// `PERSISTENT_2` offers higher `PerUnitStorageThroughput`
    /// (up to 1000 MB/s/TiB) along with a lower minimum storage capacity
    /// requirement (600 GiB).
    /// To learn more about FSx for Lustre deployment types, see [Deployment and
    /// storage class options for
    /// FSx for Lustre file
    /// systems](https://docs.aws.amazon.com/fsx/latest/LustreGuide/using-fsx-lustre.html).
    ///
    /// The default is `SCRATCH_1`.
    deployment_type: ?LustreDeploymentType = null,

    /// The type of drive cache used by `PERSISTENT_1` file systems that are
    /// provisioned with
    /// HDD storage devices. This parameter is required when `StorageType` is HDD.
    /// When set to
    /// `READ` the file system has an SSD storage cache that is sized to 20% of the
    /// file system's
    /// storage capacity. This improves the performance for frequently accessed
    /// files by caching up to 20%
    /// of the total storage capacity.
    ///
    /// This parameter is required when `StorageType` is set to HDD.
    drive_cache_type: ?DriveCacheType = null,

    /// Specifies whether Elastic Fabric Adapter (EFA) and GPUDirect Storage (GDS)
    /// support is enabled for the Amazon FSx for Lustre file system.
    efa_enabled: ?bool = null,

    /// The Lustre logging configuration. Lustre logging writes the enabled log
    /// events for your file system to Amazon CloudWatch Logs.
    log_configuration: ?LustreLogConfiguration = null,

    /// The Lustre metadata performance configuration for an Amazon FSx for Lustre
    /// file system
    /// using a `PERSISTENT_2` deployment type.
    metadata_configuration: ?FileSystemLustreMetadataConfiguration = null,

    /// You use the `MountName` value when mounting the file system.
    ///
    /// For the `SCRATCH_1` deployment type, this value is always "`fsx`".
    /// For `SCRATCH_2`, `PERSISTENT_1`, and `PERSISTENT_2` deployment
    /// types, this value is a string that is unique within an Amazon Web Services
    /// Region.
    mount_name: ?[]const u8 = null,

    /// Per unit storage throughput represents the megabytes per second of read or
    /// write
    /// throughput per 1 tebibyte of storage provisioned. File system throughput
    /// capacity is
    /// equal to Storage capacity (TiB) * PerUnitStorageThroughput (MB/s/TiB). This
    /// option is
    /// only valid for `PERSISTENT_1` and `PERSISTENT_2` deployment types.
    ///
    /// Valid values:
    ///
    /// * For `PERSISTENT_1` SSD storage: 50, 100, 200.
    ///
    /// * For `PERSISTENT_1` HDD storage: 12, 40.
    ///
    /// * For `PERSISTENT_2` SSD storage: 125, 250, 500, 1000.
    per_unit_storage_throughput: ?i32 = null,

    /// The Lustre root squash configuration for an Amazon FSx for Lustre
    /// file system. When enabled, root squash restricts root-level access from
    /// clients that
    /// try to access your file system as a root user.
    root_squash_configuration: ?LustreRootSquashConfiguration = null,

    /// The throughput of an Amazon FSx for Lustre file system using the
    /// Intelligent-Tiering
    /// storage class, measured in megabytes per second (MBps).
    throughput_capacity: ?i32 = null,

    /// The preferred start time to perform weekly maintenance, formatted d:HH:MM in
    /// the UTC
    /// time zone. Here, `d` is the weekday number, from 1 through 7, beginning with
    /// Monday and
    /// ending with Sunday.
    weekly_maintenance_start_time: ?[]const u8 = null,

    pub const json_field_names = .{
        .automatic_backup_retention_days = "AutomaticBackupRetentionDays",
        .copy_tags_to_backups = "CopyTagsToBackups",
        .daily_automatic_backup_start_time = "DailyAutomaticBackupStartTime",
        .data_compression_type = "DataCompressionType",
        .data_read_cache_configuration = "DataReadCacheConfiguration",
        .data_repository_configuration = "DataRepositoryConfiguration",
        .deployment_type = "DeploymentType",
        .drive_cache_type = "DriveCacheType",
        .efa_enabled = "EfaEnabled",
        .log_configuration = "LogConfiguration",
        .metadata_configuration = "MetadataConfiguration",
        .mount_name = "MountName",
        .per_unit_storage_throughput = "PerUnitStorageThroughput",
        .root_squash_configuration = "RootSquashConfiguration",
        .throughput_capacity = "ThroughputCapacity",
        .weekly_maintenance_start_time = "WeeklyMaintenanceStartTime",
    };
};
