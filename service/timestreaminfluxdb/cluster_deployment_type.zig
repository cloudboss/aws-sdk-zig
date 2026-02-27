pub const ClusterDeploymentType = enum {
    multi_node_read_replicas,

    pub const json_field_names = .{
        .multi_node_read_replicas = "MULTI_NODE_READ_REPLICAS",
    };
};
