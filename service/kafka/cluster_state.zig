/// The state of the Apache Kafka cluster.
pub const ClusterState = enum {
    active,
    creating,
    deleting,
    failed,
    healing,
    maintenance,
    rebooting_broker,
    updating,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .creating = "CREATING",
        .deleting = "DELETING",
        .failed = "FAILED",
        .healing = "HEALING",
        .maintenance = "MAINTENANCE",
        .rebooting_broker = "REBOOTING_BROKER",
        .updating = "UPDATING",
    };
};
