/// The Amazon RDS DB instance storage configuration used for recommendations.
pub const RdsDbInstanceStorageConfiguration = struct {
    /// The new amount of storage in GB to allocate for the DB instance.
    allocated_storage_in_gb: ?f64,

    /// The amount of Provisioned IOPS (input/output operations per second) to be
    /// initially allocated for the DB instance.
    iops: ?f64,

    /// The storage throughput for the DB instance.
    storage_throughput: ?f64,

    /// The storage type to associate with the DB instance.
    storage_type: ?[]const u8,

    pub const json_field_names = .{
        .allocated_storage_in_gb = "allocatedStorageInGb",
        .iops = "iops",
        .storage_throughput = "storageThroughput",
        .storage_type = "storageType",
    };
};
