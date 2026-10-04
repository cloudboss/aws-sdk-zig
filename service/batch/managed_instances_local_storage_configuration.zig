/// The local storage configuration for Amazon ECS Managed Instances.
pub const ManagedInstancesLocalStorageConfiguration = struct {
    /// Specifies whether instance store volumes (local NVMe SSDs) are available to
    /// containers.
    /// When enabled, containers can use the instance store for high-performance
    /// temporary
    /// storage.
    use_local_storage: ?bool = null,

    pub const json_field_names = .{
        .use_local_storage = "useLocalStorage",
    };
};
