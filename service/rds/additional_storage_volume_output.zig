/// Contains information about an additional storage volume for a DB instance.
pub const AdditionalStorageVolumeOutput = struct {
    /// The amount of storage allocated for the additional storage volume, in
    /// gibibytes (GiB). The minimum is 20 GiB. The maximum is 65,536 GiB (64 TiB).
    allocated_storage: ?i32 = null,

    /// The number of I/O operations per second (IOPS) provisioned for the
    /// additional storage volume.
    iops: ?i32 = null,

    /// The upper limit in gibibytes (GiB) to which RDS can automatically scale the
    /// storage of the additional storage volume.
    max_allocated_storage: ?i32 = null,

    /// The percentage of the in-progress storage operation on the additional
    /// storage volume that has completed, from `0` to `100`. This field appears
    /// only while a storage operation is in progress. It isn't present when no
    /// storage operation is active.
    storage_operation_percent_progress: ?i32 = null,

    /// The status of an in-progress storage operation on the additional storage
    /// volume. This field appears only while a storage operation is in progress. It
    /// isn't present when no storage operation is active. Possible values:
    ///
    /// * `Initializing` - The volume is initializing from a snapshot, such as
    ///   during a snapshot restore, point-in-time restore, read replica creation,
    ///   or blue/green deployment. Performance can be lower than provisioned until
    ///   initialization completes.
    /// * `Optimizing` - The volume is optimizing following a storage scaling or
    ///   modification operation.
    storage_operation_status: ?[]const u8 = null,

    /// The storage throughput value for the additional storage volume, in mebibytes
    /// per second (MiBps).
    storage_throughput: ?i32 = null,

    /// The storage type for the additional storage volume.
    ///
    /// Valid Values: `GP3 | IO2`
    storage_type: ?[]const u8 = null,

    /// The status of the additional storage volume.
    ///
    /// Valid Values: `ACTIVE | CREATING | DELETING | MODIFYING | NOT-IN-USE |
    /// STORAGE-OPTIMIZATION | VOLUME-FULL`
    storage_volume_status: ?[]const u8 = null,

    /// The name of the additional storage volume.
    volume_name: ?[]const u8 = null,
};
