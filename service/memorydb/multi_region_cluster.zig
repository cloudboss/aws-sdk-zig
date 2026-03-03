const RegionalCluster = @import("regional_cluster.zig").RegionalCluster;

/// Represents a multi-Region cluster.
pub const MultiRegionCluster = struct {
    /// The Amazon Resource Name (ARN) of the multi-Region cluster.
    arn: ?[]const u8 = null,

    /// The clusters in this multi-Region cluster.
    clusters: ?[]const RegionalCluster = null,

    /// The description of the multi-Region cluster.
    description: ?[]const u8 = null,

    /// The name of the engine used by the multi-Region cluster.
    engine: ?[]const u8 = null,

    /// The version of the engine used by the multi-Region cluster.
    engine_version: ?[]const u8 = null,

    /// The name of the multi-Region cluster.
    multi_region_cluster_name: ?[]const u8 = null,

    /// The name of the multi-Region parameter group associated with the cluster.
    multi_region_parameter_group_name: ?[]const u8 = null,

    /// The node type used by the multi-Region cluster.
    node_type: ?[]const u8 = null,

    /// The number of shards in the multi-Region cluster.
    number_of_shards: ?i32 = null,

    /// The current status of the multi-Region cluster.
    status: ?[]const u8 = null,

    /// Indiciates if the multi-Region cluster is TLS enabled.
    tls_enabled: ?bool = null,

    pub const json_field_names = .{
        .arn = "ARN",
        .clusters = "Clusters",
        .description = "Description",
        .engine = "Engine",
        .engine_version = "EngineVersion",
        .multi_region_cluster_name = "MultiRegionClusterName",
        .multi_region_parameter_group_name = "MultiRegionParameterGroupName",
        .node_type = "NodeType",
        .number_of_shards = "NumberOfShards",
        .status = "Status",
        .tls_enabled = "TLSEnabled",
    };
};
