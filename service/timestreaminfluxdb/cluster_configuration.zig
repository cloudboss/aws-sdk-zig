/// Configuration for node modes in the DbCluster.
pub const ClusterConfiguration = struct {
    /// Indicates if the compactor instance is a standalone instance or not.
    dedicated_compactor: ?bool = null,

    /// The number of instances in the DbCluster which can both ingest and query.
    ingest_query_instances: ?i32 = null,

    /// The number of instances in the DbCluster which can only query.
    query_only_instances: ?i32 = null,

    pub const json_field_names = .{
        .dedicated_compactor = "dedicatedCompactor",
        .ingest_query_instances = "ingestQueryInstances",
        .query_only_instances = "queryOnlyInstances",
    };
};
