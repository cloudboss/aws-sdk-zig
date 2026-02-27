/// Contains the available options for additional storage volumes for a DB
/// instance class.
pub const AvailableAdditionalStorageVolumesOption = struct {
    /// The maximum number of I/O operations per second (IOPS) that the additional
    /// storage volume supports.
    max_iops: ?i32,

    /// The maximum ratio of I/O operations per second (IOPS) to gibibytes (GiB) of
    /// storage for the additional storage volume.
    max_iops_per_gib: ?f64,

    /// The maximum amount of storage that you can allocate for the additional
    /// storage volume, in gibibytes (GiB).
    max_storage_size: ?i32,

    /// The maximum storage throughput that the additional storage volume supports,
    /// in mebibytes per second (MiBps).
    max_storage_throughput: ?i32,

    /// The minimum number of I/O operations per second (IOPS) that the additional
    /// storage volume supports.
    min_iops: ?i32,

    /// The minimum ratio of I/O operations per second (IOPS) to gibibytes (GiB) of
    /// storage for the additional storage volume.
    min_iops_per_gib: ?f64,

    /// The minimum amount of storage that you can allocate for the additional
    /// storage volume, in gibibytes (GiB).
    min_storage_size: ?i32,

    /// The minimum storage throughput that the additional storage volume supports,
    /// in mebibytes per second (MiBps).
    min_storage_throughput: ?i32,

    /// The storage type for the additional storage volume.
    ///
    /// Valid Values: `GP3 | IO2`
    storage_type: ?[]const u8,

    /// Indicates whether the additional storage volume supports provisioned IOPS.
    supports_iops: ?bool,

    /// Indicates whether the additional storage volume supports storage
    /// autoscaling.
    supports_storage_autoscaling: ?bool,

    /// Indicates whether the additional storage volume supports configurable
    /// storage throughput.
    supports_storage_throughput: ?bool,
};
