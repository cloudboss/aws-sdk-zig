const ReplicationConfigurationReplicatedDiskStagingDiskType = @import("replication_configuration_replicated_disk_staging_disk_type.zig").ReplicationConfigurationReplicatedDiskStagingDiskType;

/// Replication Configuration replicated disk.
pub const ReplicationConfigurationReplicatedDisk = struct {
    /// Replication Configuration replicated disk device name.
    device_name: ?[]const u8,

    /// Replication Configuration replicated disk IOPs.
    iops: i64 = 0,

    /// Replication Configuration replicated disk boot disk.
    is_boot_disk: ?bool,

    /// Replication Configuration replicated disk staging disk type.
    staging_disk_type: ?ReplicationConfigurationReplicatedDiskStagingDiskType,

    /// Replication Configuration replicated disk throughput.
    throughput: i64 = 0,

    pub const json_field_names = .{
        .device_name = "deviceName",
        .iops = "iops",
        .is_boot_disk = "isBootDisk",
        .staging_disk_type = "stagingDiskType",
        .throughput = "throughput",
    };
};
