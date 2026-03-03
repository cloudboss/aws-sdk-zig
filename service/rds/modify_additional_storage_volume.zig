/// Contains details about the modification of an additional storage volume.
pub const ModifyAdditionalStorageVolume = struct {
    /// The amount of storage allocated for the additional storage volume, in
    /// gibibytes (GiB). The minimum is 20 GiB. The maximum is 65,536 GiB (64 TiB).
    allocated_storage: ?i32 = null,

    /// The number of I/O operations per second (IOPS) provisioned for the
    /// additional storage volume. This setting is only supported for Provisioned
    /// IOPS SSD (`io1` and `io2`) storage types.
    iops: ?i32 = null,

    /// The upper limit in gibibytes (GiB) to which RDS can automatically scale the
    /// storage of the additional storage volume. You must provide a value greater
    /// than or equal to `AllocatedStorage`.
    max_allocated_storage: ?i32 = null,

    /// Indicates whether to delete the additional storage volume. The value `true`
    /// schedules the volume for deletion. You can delete an additional storage
    /// volume only when it doesn't contain database files or other data.
    set_for_delete: ?bool = null,

    /// The storage throughput value for the additional storage volume, in mebibytes
    /// per second (MiBps). This setting applies only to the General Purpose SSD
    /// (`gp3`) storage type.
    storage_throughput: ?i32 = null,

    /// The new storage type for the additional storage volume.
    ///
    /// Valid Values: `GP3 | IO2`
    storage_type: ?[]const u8 = null,

    /// The name of the additional storage volume that you want to modify.
    ///
    /// Valid Values: `RDSDBDATA2 | RDSDBDATA3 | RDSDBDATA4`
    volume_name: []const u8,
};
