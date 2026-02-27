const FileCacheLustreDeploymentType = @import("file_cache_lustre_deployment_type.zig").FileCacheLustreDeploymentType;
const FileCacheLustreMetadataConfiguration = @import("file_cache_lustre_metadata_configuration.zig").FileCacheLustreMetadataConfiguration;

/// The Amazon File Cache configuration for the cache that you are creating.
pub const CreateFileCacheLustreConfiguration = struct {
    /// Specifies the cache deployment type, which must be `CACHE_1`.
    deployment_type: FileCacheLustreDeploymentType,

    /// The configuration for a Lustre MDT (Metadata Target) storage volume.
    metadata_configuration: FileCacheLustreMetadataConfiguration,

    /// Provisions the amount of read and write throughput for each 1 tebibyte (TiB)
    /// of cache storage capacity, in MB/s/TiB. The only supported
    /// value is `1000`.
    per_unit_storage_throughput: i32,

    weekly_maintenance_start_time: ?[]const u8,

    pub const json_field_names = .{
        .deployment_type = "DeploymentType",
        .metadata_configuration = "MetadataConfiguration",
        .per_unit_storage_throughput = "PerUnitStorageThroughput",
        .weekly_maintenance_start_time = "WeeklyMaintenanceStartTime",
    };
};
