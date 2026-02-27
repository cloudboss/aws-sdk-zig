const AutoImportPolicyType = @import("auto_import_policy_type.zig").AutoImportPolicyType;
const DataCompressionType = @import("data_compression_type.zig").DataCompressionType;
const LustreReadCacheConfiguration = @import("lustre_read_cache_configuration.zig").LustreReadCacheConfiguration;
const LustreDeploymentType = @import("lustre_deployment_type.zig").LustreDeploymentType;
const DriveCacheType = @import("drive_cache_type.zig").DriveCacheType;
const LustreLogCreateConfiguration = @import("lustre_log_create_configuration.zig").LustreLogCreateConfiguration;
const CreateFileSystemLustreMetadataConfiguration = @import("create_file_system_lustre_metadata_configuration.zig").CreateFileSystemLustreMetadataConfiguration;
const LustreRootSquashConfiguration = @import("lustre_root_squash_configuration.zig").LustreRootSquashConfiguration;

/// The Lustre configuration for the file system being created.
///
/// The following parameters are not supported for file systems
/// with a data repository association created with
/// .
///
/// * `AutoImportPolicy`
///
/// * `ExportPath`
///
/// * `ImportedFileChunkSize`
///
/// * `ImportPath`
pub const CreateFileSystemLustreConfiguration = struct {
    /// (Optional) When you create your file system, your existing S3 objects appear
    /// as file and
    /// directory listings. Use this parameter to choose how Amazon FSx keeps your
    /// file and directory
    /// listings up to date as you add or modify objects in your linked S3 bucket.
    /// `AutoImportPolicy`
    /// can have the following values:
    ///
    /// * `NONE` - (Default) AutoImport is off. Amazon FSx only updates
    /// file and directory listings from the linked S3 bucket
    /// when the file system is created. FSx does not update file and directory
    /// listings for any new or changed objects after choosing this option.
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
    /// For more information, see [
    /// Automatically import updates from your S3
    /// bucket](https://docs.aws.amazon.com/fsx/latest/LustreGuide/older-deployment-types.html#legacy-auto-import-from-s3).
    ///
    /// This parameter is not supported for file systems with a data repository
    /// association.
    auto_import_policy: ?AutoImportPolicyType,

    /// The number of days to retain automatic backups. Setting this property to
    /// `0` disables automatic backups. You can retain automatic backups for a
    /// maximum of 90 days. The default is `0`.
    automatic_backup_retention_days: ?i32,

    /// (Optional) Not available for use with file systems that are linked to a data
    /// repository. A boolean flag indicating whether tags for the file system
    /// should be copied
    /// to backups. The default value is false. If `CopyTagsToBackups` is set to
    /// true, all file system tags are copied to all automatic and user-initiated
    /// backups when
    /// the user doesn't specify any backup-specific tags. If
    /// `CopyTagsToBackups` is set to true and you specify one or more backup
    /// tags, only the specified tags are copied to backups. If you specify one or
    /// more tags
    /// when creating a user-initiated backup, no tags are copied from the file
    /// system,
    /// regardless of this value.
    ///
    /// (Default = `false`)
    ///
    /// For more information, see [
    /// Working with
    /// backups](https://docs.aws.amazon.com/fsx/latest/LustreGuide/using-backups-fsx.html) in the *Amazon FSx for Lustre User Guide*.
    copy_tags_to_backups: ?bool,

    daily_automatic_backup_start_time: ?[]const u8,

    /// Sets the data compression configuration for the file system.
    /// `DataCompressionType`
    /// can have the following values:
    ///
    /// * `NONE` - (Default) Data compression is turned off when
    /// the file system is created.
    ///
    /// * `LZ4` - Data compression is turned on with the LZ4
    /// algorithm.
    ///
    /// For more information, see [Lustre data
    /// compression](https://docs.aws.amazon.com/fsx/latest/LustreGuide/data-compression.html)
    /// in the *Amazon FSx for Lustre User Guide*.
    data_compression_type: ?DataCompressionType,

    /// Specifies the optional provisioned SSD read cache on FSx for Lustre file
    /// systems that
    /// use the Intelligent-Tiering storage class. Required when `StorageType` is
    /// set
    /// to `INTELLIGENT_TIERING`.
    data_read_cache_configuration: ?LustreReadCacheConfiguration,

    /// (Optional) Choose `SCRATCH_1` and `SCRATCH_2` deployment
    /// types when you need temporary storage and shorter-term processing of data.
    /// The `SCRATCH_2` deployment type provides in-transit encryption of data and
    /// higher burst
    /// throughput capacity than `SCRATCH_1`.
    ///
    /// Choose `PERSISTENT_1` for longer-term storage and for throughput-focused
    /// workloads that aren’t latency-sensitive.
    /// `PERSISTENT_1` supports encryption of data in transit, and is available in
    /// all
    /// Amazon Web Services Regions in which FSx for Lustre is available.
    ///
    /// Choose `PERSISTENT_2` for longer-term storage and for latency-sensitive
    /// workloads
    /// that require the highest levels of IOPS/throughput. `PERSISTENT_2` supports
    /// the SSD and Intelligent-Tiering storage classes.
    /// You can optionally specify a metadata configuration mode for `PERSISTENT_2`
    /// which supports increasing metadata performance. `PERSISTENT_2` is available
    /// in a limited number of Amazon Web Services Regions. For more information,
    /// and an up-to-date
    /// list of Amazon Web Services Regions in which `PERSISTENT_2` is available,
    /// see
    /// [Deployment and
    /// storage class options for FSx for Lustre file
    /// systems](https://docs.aws.amazon.com/fsx/latest/LustreGuide/using-fsx-lustre.html) in
    /// the *Amazon FSx for Lustre User Guide*.
    ///
    /// If you choose `PERSISTENT_2`, and you set `FileSystemTypeVersion` to
    /// `2.10`, the `CreateFileSystem` operation fails.
    ///
    /// Encryption of data in transit is automatically turned on when you access
    /// `SCRATCH_2`, `PERSISTENT_1`, and `PERSISTENT_2` file
    /// systems from Amazon EC2 instances that support automatic encryption in
    /// the Amazon Web Services Regions where they are available. For more
    /// information about
    /// encryption in transit for FSx for Lustre file systems, see [Encrypting data
    /// in
    /// transit](https://docs.aws.amazon.com/fsx/latest/LustreGuide/encryption-in-transit-fsxl.html) in the *Amazon FSx for Lustre User Guide*.
    ///
    /// (Default = `SCRATCH_1`)
    deployment_type: ?LustreDeploymentType,

    /// The type of drive cache used by `PERSISTENT_1` file systems that are
    /// provisioned with
    /// HDD storage devices. This parameter is required when storage type is HDD.
    /// Set this property to
    /// `READ` to improve the performance for frequently accessed files by caching
    /// up to 20%
    /// of the total storage capacity of the file system.
    ///
    /// This parameter is required when `StorageType` is set to `HDD`.
    drive_cache_type: ?DriveCacheType,

    /// (Optional) Specifies whether Elastic Fabric Adapter (EFA) and GPUDirect
    /// Storage (GDS)
    /// support is enabled for the Amazon FSx for Lustre file system.
    ///
    /// (Default = `false`)
    efa_enabled: ?bool,

    /// (Optional) Specifies the path in the Amazon S3 bucket where the root of your
    /// Amazon FSx file system is exported. The path must use the same Amazon S3
    /// bucket as specified in ImportPath. You can provide an optional prefix to
    /// which new and
    /// changed data is to be exported from your Amazon FSx for Lustre file system.
    /// If
    /// an `ExportPath` value is not provided, Amazon FSx sets a default export
    /// path,
    /// `s3://import-bucket/FSxLustre[creation-timestamp]`. The timestamp is in
    /// UTC format, for example
    /// `s3://import-bucket/FSxLustre20181105T222312Z`.
    ///
    /// The Amazon S3 export bucket must be the same as the import bucket specified
    /// by
    /// `ImportPath`. If you specify only a bucket name, such as
    /// `s3://import-bucket`, you get a 1:1 mapping of file system objects to S3
    /// bucket objects. This mapping means that the input data in S3 is overwritten
    /// on export.
    /// If you provide a custom prefix in the export path, such as
    /// `s3://import-bucket/[custom-optional-prefix]`, Amazon FSx exports the
    /// contents of your file
    /// system to that export prefix in the Amazon S3 bucket.
    ///
    /// This parameter is not supported for file systems with a data repository
    /// association.
    export_path: ?[]const u8,

    /// (Optional) For files imported from a data repository, this value determines
    /// the stripe
    /// count and maximum amount of data per file (in MiB) stored on a single
    /// physical disk. The
    /// maximum number of disks that a single file can be striped across is limited
    /// by the total
    /// number of disks that make up the file system.
    ///
    /// The default chunk size is 1,024 MiB (1 GiB) and can go as high as 512,000
    /// MiB (500
    /// GiB). Amazon S3 objects have a maximum size of 5 TB.
    ///
    /// This parameter is not supported for file systems with a data repository
    /// association.
    imported_file_chunk_size: ?i32,

    /// (Optional) The path to the Amazon S3 bucket (including the optional prefix)
    /// that
    /// you're using as the data repository for your Amazon FSx for Lustre file
    /// system.
    /// The root of your FSx for Lustre file system will
    /// be mapped to the root of the Amazon S3 bucket you select. An
    /// example is `s3://import-bucket/optional-prefix`. If you specify a prefix
    /// after the Amazon S3 bucket name, only object keys with that prefix are
    /// loaded into the
    /// file system.
    ///
    /// This parameter is not supported for file systems with a data repository
    /// association.
    import_path: ?[]const u8,

    /// The Lustre logging configuration used when creating an Amazon FSx for Lustre
    /// file system. When logging is enabled, Lustre logs error and warning events
    /// for data repositories
    /// associated with your file system to Amazon CloudWatch Logs.
    log_configuration: ?LustreLogCreateConfiguration,

    /// The Lustre metadata performance configuration for the creation of an
    /// FSx for Lustre file system using a `PERSISTENT_2`
    /// deployment type.
    metadata_configuration: ?CreateFileSystemLustreMetadataConfiguration,

    /// Required with `PERSISTENT_1` and `PERSISTENT_2` deployment
    /// types using an SSD or HDD storage class, provisions the amount of read and
    /// write throughput for each 1 tebibyte (TiB) of
    /// file system storage capacity, in MB/s/TiB. File system throughput capacity
    /// is calculated
    /// by multiplying ﬁle system storage capacity (TiB) by the
    /// `PerUnitStorageThroughput` (MB/s/TiB). For a 2.4-TiB ﬁle system,
    /// provisioning 50 MB/s/TiB of `PerUnitStorageThroughput` yields 120 MB/s of
    /// ﬁle
    /// system throughput. You pay for the amount of throughput that you provision.
    ///
    /// Valid values:
    ///
    /// * For `PERSISTENT_1` SSD storage: 50, 100, 200 MB/s/TiB.
    ///
    /// * For `PERSISTENT_1` HDD storage: 12, 40 MB/s/TiB.
    ///
    /// * For `PERSISTENT_2` SSD storage: 125, 250, 500, 1000 MB/s/TiB.
    per_unit_storage_throughput: ?i32,

    /// The Lustre root squash configuration used when creating an Amazon FSx for
    /// Lustre
    /// file system. When enabled, root squash restricts root-level access from
    /// clients that
    /// try to access your file system as a root user.
    root_squash_configuration: ?LustreRootSquashConfiguration,

    /// Specifies the throughput of an FSx for Lustre file system using the
    /// Intelligent-Tiering storage class,
    /// measured in megabytes per second (MBps). Valid values are 4000 MBps or
    /// multiples of 4000 MBps. You pay for the amount of throughput that you
    /// provision.
    throughput_capacity: ?i32,

    /// (Optional) The preferred start time to perform weekly maintenance, formatted
    /// d:HH:MM in the UTC
    /// time zone, where d is the weekday number, from 1 through 7, beginning with
    /// Monday and ending with Sunday.
    weekly_maintenance_start_time: ?[]const u8,

    pub const json_field_names = .{
        .auto_import_policy = "AutoImportPolicy",
        .automatic_backup_retention_days = "AutomaticBackupRetentionDays",
        .copy_tags_to_backups = "CopyTagsToBackups",
        .daily_automatic_backup_start_time = "DailyAutomaticBackupStartTime",
        .data_compression_type = "DataCompressionType",
        .data_read_cache_configuration = "DataReadCacheConfiguration",
        .deployment_type = "DeploymentType",
        .drive_cache_type = "DriveCacheType",
        .efa_enabled = "EfaEnabled",
        .export_path = "ExportPath",
        .imported_file_chunk_size = "ImportedFileChunkSize",
        .import_path = "ImportPath",
        .log_configuration = "LogConfiguration",
        .metadata_configuration = "MetadataConfiguration",
        .per_unit_storage_throughput = "PerUnitStorageThroughput",
        .root_squash_configuration = "RootSquashConfiguration",
        .throughput_capacity = "ThroughputCapacity",
        .weekly_maintenance_start_time = "WeeklyMaintenanceStartTime",
    };
};
