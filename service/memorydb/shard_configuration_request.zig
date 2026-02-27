/// A request to configure the sharding properties of a cluster
pub const ShardConfigurationRequest = struct {
    /// The number of shards in the cluster
    shard_count: i32 = 0,

    pub const json_field_names = .{
        .shard_count = "ShardCount",
    };
};
