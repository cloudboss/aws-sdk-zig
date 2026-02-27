/// Contains details about an additional storage volume for a DB instance. RDS
/// support additional storage volumes for RDS for Oracle and RDS for SQL
/// Server.
pub const AdditionalStorageVolume = struct {
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
    /// per second (MiBps). This setting applies only to the General Purpose SSD
    /// (`gp3`) storage type.
    storage_throughput: ?i32,

    /// The storage type for the additional storage volume.
    ///
    /// Valid Values: `GP3 | IO2`
    storage_type: ?[]const u8,

    /// The name of the additional storage volume.
    ///
    /// Valid Values: `RDSDBDATA2 | RDSDBDATA3 | RDSDBDATA4`
    volume_name: []const u8,
};
