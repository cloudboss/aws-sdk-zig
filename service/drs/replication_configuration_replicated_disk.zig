const ReplicationConfigurationReplicatedDiskStagingDiskType = @import("replication_configuration_replicated_disk_staging_disk_type.zig").ReplicationConfigurationReplicatedDiskStagingDiskType;

/// The configuration of a disk of the Source Server to be replicated.
pub const ReplicationConfigurationReplicatedDisk = struct {
    /// The name of the device.
    device_name: ?[]const u8,

    /// The requested number of I/O operations per second (IOPS).
    iops: i64 = 0,

    /// Whether to boot from this disk or not.
    is_boot_disk: ?bool,

    /// The Staging Disk EBS volume type to be used during replication when
    /// `stagingDiskType` is set to Auto. This is a read-only field.
    optimized_staging_disk_type: ?ReplicationConfigurationReplicatedDiskStagingDiskType,

    /// The Staging Disk EBS volume type to be used during replication.
    staging_disk_type: ?ReplicationConfigurationReplicatedDiskStagingDiskType,

    /// The throughput to use for the EBS volume in MiB/s. This parameter is valid
    /// only for gp3 volumes.
    throughput: i64 = 0,

    pub const json_field_names = .{
        .device_name = "deviceName",
        .iops = "iops",
        .is_boot_disk = "isBootDisk",
        .optimized_staging_disk_type = "optimizedStagingDiskType",
        .staging_disk_type = "stagingDiskType",
        .throughput = "throughput",
    };
};
