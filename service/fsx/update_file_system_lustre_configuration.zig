const AutoImportPolicyType = @import("auto_import_policy_type.zig").AutoImportPolicyType;
const DataCompressionType = @import("data_compression_type.zig").DataCompressionType;
const LustreReadCacheConfiguration = @import("lustre_read_cache_configuration.zig").LustreReadCacheConfiguration;
const LustreLogCreateConfiguration = @import("lustre_log_create_configuration.zig").LustreLogCreateConfiguration;
const UpdateFileSystemLustreMetadataConfiguration = @import("update_file_system_lustre_metadata_configuration.zig").UpdateFileSystemLustreMetadataConfiguration;
const LustreRootSquashConfiguration = @import("lustre_root_squash_configuration.zig").LustreRootSquashConfiguration;

/// The configuration object for Amazon FSx for Lustre file systems used in the
/// `UpdateFileSystem` operation.
pub const UpdateFileSystemLustreConfiguration = struct {
    /// (Optional) When you create your file system, your existing S3 objects appear
    /// as file and directory listings.
    /// Use this property to choose how Amazon FSx keeps your file and directory
    /// listing up to date
    /// as you add or modify objects in your linked S3 bucket. `AutoImportPolicy`
    /// can
    /// have the following values:
    ///
    /// * `NONE` - (Default) AutoImport is off. Amazon FSx only updates
    /// file and directory listings from the linked S3 bucket
    /// when the file system is created. FSx does not update the file and directory
    /// listing for any new or changed objects after choosing this option.
    ///
    /// * `NEW` - AutoImport is on. Amazon FSx automatically imports
    /// directory listings of any new objects added to the linked S3 bucket that
    /// do not currently exist in the FSx file system.
    ///
    /// * `NEW_CHANGED` - AutoImport is on. Amazon FSx automatically imports
    /// file and directory listings of any new objects added to the S3 bucket and
    /// any
    /// existing objects that are changed in the S3 bucket after you choose this
    /// option.
    ///
    /// * `NEW_CHANGED_DELETED` - AutoImport is on. Amazon FSx automatically
    /// imports file and directory listings of any new objects added to the S3
    /// bucket, any
    /// existing objects that are changed in the S3 bucket, and any objects that
    /// were deleted
    /// in the S3 bucket.
    ///
    /// This parameter is not supported for file systems with a data repository
    /// association.
    auto_import_policy: ?AutoImportPolicyType = null,

    /// The number of days to retain automatic backups. Setting this property to
    /// `0` disables automatic backups. You can retain automatic backups for a
    /// maximum of 90 days. The default is `0`.
    automatic_backup_retention_days: ?i32 = null,

    daily_automatic_backup_start_time: ?[]const u8 = null,

    /// Sets the data compression configuration for the file system.
    /// `DataCompressionType`
    /// can have the following values:
    ///
    /// * `NONE` - Data compression is turned off for
    /// the file system.
    ///
    /// * `LZ4` - Data compression is turned on with the LZ4
    /// algorithm.
    ///
    /// If you don't use `DataCompressionType`, the file system retains
    /// its current data compression configuration.
    ///
    /// For more information, see [Lustre data
    /// compression](https://docs.aws.amazon.com/fsx/latest/LustreGuide/data-compression.html).
    data_compression_type: ?DataCompressionType = null,

    /// Specifies the optional provisioned SSD read cache on Amazon FSx for Lustre
    /// file systems that
    /// use the Intelligent-Tiering storage class.
    data_read_cache_configuration: ?LustreReadCacheConfiguration = null,

    /// The Lustre logging configuration used when updating an Amazon FSx for Lustre
    /// file system. When logging is enabled, Lustre logs error and warning events
    /// for
    /// data repositories associated with your file system to Amazon CloudWatch
    /// Logs.
    log_configuration: ?LustreLogCreateConfiguration = null,

    /// The Lustre metadata performance configuration for an Amazon FSx for Lustre
    /// file system using a `PERSISTENT_2` deployment type. When this configuration
    /// is enabled, the file system supports increasing metadata performance.
    metadata_configuration: ?UpdateFileSystemLustreMetadataConfiguration = null,

    /// The throughput of an Amazon FSx for Lustre Persistent SSD-based file system,
    /// measured in megabytes per second per tebibyte (MB/s/TiB). You can increase
    /// or decrease
    /// your file system's throughput. Valid values depend on the deployment type of
    /// the file
    /// system, as follows:
    ///
    /// * For `PERSISTENT_1` SSD-based deployment types, valid values
    /// are 50, 100, and 200 MB/s/TiB.
    ///
    /// * For `PERSISTENT_2` SSD-based deployment types, valid values
    /// are 125, 250, 500, and 1000 MB/s/TiB.
    ///
    /// For more information, see
    /// [
    /// Managing throughput
    /// capacity](https://docs.aws.amazon.com/fsx/latest/LustreGuide/managing-throughput-capacity.html).
    per_unit_storage_throughput: ?i32 = null,

    /// The Lustre root squash configuration used when updating an Amazon FSx for
    /// Lustre
    /// file system. When enabled, root squash restricts root-level access from
    /// clients that
    /// try to access your file system as a root user.
    root_squash_configuration: ?LustreRootSquashConfiguration = null,

    /// The throughput of an Amazon FSx for Lustre file system using an
    /// Intelligent-Tiering
    /// storage class, measured in megabytes per second (MBps). You can only
    /// increase your file
    /// system's throughput. Valid values are 4000 MBps or multiples of 4000 MBps.
    throughput_capacity: ?i32 = null,

    /// (Optional) The preferred start time to perform weekly maintenance, formatted
    /// d:HH:MM in the UTC
    /// time zone. d is the weekday number, from 1 through 7, beginning with Monday
    /// and ending with Sunday.
    weekly_maintenance_start_time: ?[]const u8 = null,

    pub const json_field_names = .{
        .auto_import_policy = "AutoImportPolicy",
        .automatic_backup_retention_days = "AutomaticBackupRetentionDays",
        .daily_automatic_backup_start_time = "DailyAutomaticBackupStartTime",
        .data_compression_type = "DataCompressionType",
        .data_read_cache_configuration = "DataReadCacheConfiguration",
        .log_configuration = "LogConfiguration",
        .metadata_configuration = "MetadataConfiguration",
        .per_unit_storage_throughput = "PerUnitStorageThroughput",
        .root_squash_configuration = "RootSquashConfiguration",
        .throughput_capacity = "ThroughputCapacity",
        .weekly_maintenance_start_time = "WeeklyMaintenanceStartTime",
    };
};
