/// The storage configuration for Amazon ECS Managed Instances.
pub const ManagedInstancesStorageConfiguration = struct {
    /// The size of the root EBS volume in GiB for the managed instances.
    storage_size_gi_b: ?i32 = null,

    pub const json_field_names = .{
        .storage_size_gi_b = "storageSizeGiB",
    };
};
