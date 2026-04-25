/// Contains information about the Amazon EC2 instance that is running the
/// Amazon ECS container.
pub const ContainerInstanceDetails = struct {
    /// Represents total number of nodes in the Amazon ECS cluster.
    compatible_container_instances: ?i64 = null,

    /// Represents the nodes in the Amazon ECS cluster that has a `HEALTHY` coverage
    /// status.
    covered_container_instances: ?i64 = null,

    pub const json_field_names = .{
        .compatible_container_instances = "CompatibleContainerInstances",
        .covered_container_instances = "CoveredContainerInstances",
    };
};
