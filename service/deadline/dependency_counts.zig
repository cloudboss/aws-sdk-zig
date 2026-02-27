/// The number of dependencies for the consumer.
pub const DependencyCounts = struct {
    /// The number of consumers resolved.
    consumers_resolved: i32,

    /// The number of unresolved consumers.
    consumers_unresolved: i32,

    /// The number of resolved dependencies.
    dependencies_resolved: i32,

    /// The number of unresolved dependencies.
    dependencies_unresolved: i32,

    pub const json_field_names = .{
        .consumers_resolved = "consumersResolved",
        .consumers_unresolved = "consumersUnresolved",
        .dependencies_resolved = "dependenciesResolved",
        .dependencies_unresolved = "dependenciesUnresolved",
    };
};
