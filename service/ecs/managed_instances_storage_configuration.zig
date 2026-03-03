/// The storage configuration for Amazon ECS Managed Instances. This defines the
/// root
/// volume configuration for the instances.
pub const ManagedInstancesStorageConfiguration = struct {
    /// The size of the tasks volume.
    storage_size_gi_b: ?i32 = null,

    pub const json_field_names = .{
        .storage_size_gi_b = "storageSizeGiB",
    };
};
