/// The configuration of a resource pool for an Autonomous Database.
pub const ResourcePoolSummary = struct {
    /// The available compute capacity in the resource pool.
    available_compute_capacity: ?i32 = null,

    /// The available storage capacity in the resource pool, in TB.
    available_storage_capacity_in_t_bs: ?f64 = null,

    /// Indicates whether the resource pool is disabled.
    is_disabled: ?bool = null,

    /// The number of Autonomous Databases that the resource pool can contain.
    pool_size: ?i32 = null,

    /// The total storage size of the resource pool, in terabytes (TB).
    pool_storage_size_in_t_bs: ?i32 = null,

    /// The total compute capacity of the resource pool.
    total_compute_capacity: ?i32 = null,

    pub const json_field_names = .{
        .available_compute_capacity = "availableComputeCapacity",
        .available_storage_capacity_in_t_bs = "availableStorageCapacityInTBs",
        .is_disabled = "isDisabled",
        .pool_size = "poolSize",
        .pool_storage_size_in_t_bs = "poolStorageSizeInTBs",
        .total_compute_capacity = "totalComputeCapacity",
    };
};
