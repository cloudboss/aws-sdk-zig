/// A request to configure the number of replicas in a shard
pub const ReplicaConfigurationRequest = struct {
    /// The number of replicas to scale up or down to
    replica_count: i32 = 0,

    pub const json_field_names = .{
        .replica_count = "ReplicaCount",
    };
};
