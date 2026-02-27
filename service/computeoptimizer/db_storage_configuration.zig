/// The configuration of the recommended RDS storage.
pub const DBStorageConfiguration = struct {
    /// The size of the DB storage in gigabytes (GB).
    allocated_storage: i32 = 0,

    /// The provisioned IOPs of the DB storage.
    iops: ?i32,

    /// The maximum limit in gibibytes (GiB) to which Amazon RDS can automatically
    /// scale the storage of the DB instance.
    max_allocated_storage: ?i32,

    /// The storage throughput of the DB storage.
    storage_throughput: ?i32,

    /// The type of DB storage.
    storage_type: ?[]const u8,

    pub const json_field_names = .{
        .allocated_storage = "allocatedStorage",
        .iops = "iops",
        .max_allocated_storage = "maxAllocatedStorage",
        .storage_throughput = "storageThroughput",
        .storage_type = "storageType",
    };
};
