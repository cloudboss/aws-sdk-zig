/// The local storage configuration for Amazon ECS Managed Instances. This
/// defines how ECS uses and configures instance store volumes available on
/// container instance.
pub const ManagedInstancesLocalStorageConfiguration = struct {
    /// Use instance store volumes for data storage when available. EBS volumes are
    /// not provisioned for data storage. If the container instance has multiple
    /// instance store volumes, a single data volume is created. Consider defining
    /// instance store requirements using the `localStorage`, `localStorageTypes`
    /// and `totalLocalStorageGB` properties.
    use_local_storage: bool = false,

    pub const json_field_names = .{
        .use_local_storage = "useLocalStorage",
    };
};
