const FileCacheLustreDeploymentType = @import("file_cache_lustre_deployment_type.zig").FileCacheLustreDeploymentType;
const LustreLogConfiguration = @import("lustre_log_configuration.zig").LustreLogConfiguration;
const FileCacheLustreMetadataConfiguration = @import("file_cache_lustre_metadata_configuration.zig").FileCacheLustreMetadataConfiguration;

/// The configuration for the Amazon File Cache resource.
pub const FileCacheLustreConfiguration = struct {
    /// The deployment type of the Amazon File Cache resource, which must
    /// be `CACHE_1`.
    deployment_type: ?FileCacheLustreDeploymentType,

    /// The configuration for Lustre logging used to write the enabled
    /// logging events for your Amazon File Cache resource to Amazon CloudWatch
    /// Logs.
    log_configuration: ?LustreLogConfiguration,

    /// The configuration for a Lustre MDT (Metadata Target) storage volume.
    metadata_configuration: ?FileCacheLustreMetadataConfiguration,

    /// You use the `MountName` value when mounting the cache. If you pass
    /// a cache ID to the `DescribeFileCaches` operation, it returns the
    /// the `MountName` value as part of the cache's description.
    mount_name: ?[]const u8,

    /// Per unit storage throughput represents the megabytes per second of read or
    /// write
    /// throughput per 1 tebibyte of storage provisioned. Cache throughput capacity
    /// is
    /// equal to Storage capacity (TiB) * PerUnitStorageThroughput (MB/s/TiB). The
    /// only
    /// supported value is `1000`.
    per_unit_storage_throughput: ?i32,

    weekly_maintenance_start_time: ?[]const u8,

    pub const json_field_names = .{
        .deployment_type = "DeploymentType",
        .log_configuration = "LogConfiguration",
        .metadata_configuration = "MetadataConfiguration",
        .mount_name = "MountName",
        .per_unit_storage_throughput = "PerUnitStorageThroughput",
        .weekly_maintenance_start_time = "WeeklyMaintenanceStartTime",
    };
};
