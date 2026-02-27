/// Contains information about an additional storage volume for a DB instance.
pub const AdditionalStorageVolumeOutput = struct {
    /// The amount of storage allocated for the additional storage volume, in
    /// gibibytes (GiB). The minimum is 20 GiB. The maximum is 65,536 GiB (64 TiB).
    allocated_storage: ?i32,

    /// The number of I/O operations per second (IOPS) provisioned for the
    /// additional storage volume.
    iops: ?i32,

    /// The upper limit in gibibytes (GiB) to which RDS can automatically scale the
    /// storage of the additional storage volume.
    max_allocated_storage: ?i32,

    /// The storage throughput value for the additional storage volume, in mebibytes
    /// per second (MiBps).
    storage_throughput: ?i32,

    /// The storage type for the additional storage volume.
    ///
    /// Valid Values: `GP3 | IO2`
    storage_type: ?[]const u8,

    /// The status of the additional storage volume.
    ///
    /// Valid Values: `ACTIVE | CREATING | DELETING | MODIFYING | NOT-IN-USE |
    /// STORAGE-OPTIMIZATION | VOLUME-FULL`
    storage_volume_status: ?[]const u8,

    /// The name of the additional storage volume.
    volume_name: ?[]const u8,
};
