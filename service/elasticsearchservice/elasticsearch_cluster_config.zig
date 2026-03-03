const ColdStorageOptions = @import("cold_storage_options.zig").ColdStorageOptions;
const ESPartitionInstanceType = @import("es_partition_instance_type.zig").ESPartitionInstanceType;
const ESWarmPartitionInstanceType = @import("es_warm_partition_instance_type.zig").ESWarmPartitionInstanceType;
const ZoneAwarenessConfig = @import("zone_awareness_config.zig").ZoneAwarenessConfig;

/// Specifies the configuration for the domain cluster, such as the type and
/// number of instances.
pub const ElasticsearchClusterConfig = struct {
    /// Specifies the `ColdStorageOptions` config for Elasticsearch Domain
    cold_storage_options: ?ColdStorageOptions = null,

    /// Total number of dedicated master nodes, active and on standby, for the
    /// cluster.
    dedicated_master_count: ?i32 = null,

    /// A boolean value to indicate whether a dedicated master node is enabled. See
    /// [About Dedicated Master
    /// Nodes](http://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-managedomains.html#es-managedomains-dedicatedmasternodes) for more information.
    dedicated_master_enabled: ?bool = null,

    /// The instance type for a dedicated master node.
    dedicated_master_type: ?ESPartitionInstanceType = null,

    /// The number of instances in the specified domain cluster.
    instance_count: ?i32 = null,

    /// The instance type for an Elasticsearch cluster. UltraWarm instance types are
    /// not supported for data instances.
    instance_type: ?ESPartitionInstanceType = null,

    /// The number of warm nodes in the cluster.
    warm_count: ?i32 = null,

    /// True to enable warm storage.
    warm_enabled: ?bool = null,

    /// The instance type for the Elasticsearch cluster's warm nodes.
    warm_type: ?ESWarmPartitionInstanceType = null,

    /// Specifies the zone awareness configuration for a domain when zone awareness
    /// is enabled.
    zone_awareness_config: ?ZoneAwarenessConfig = null,

    /// A boolean value to indicate whether zone awareness is enabled. See [About
    /// Zone
    /// Awareness](http://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-managedomains.html#es-managedomains-zoneawareness) for more information.
    zone_awareness_enabled: ?bool = null,

    pub const json_field_names = .{
        .cold_storage_options = "ColdStorageOptions",
        .dedicated_master_count = "DedicatedMasterCount",
        .dedicated_master_enabled = "DedicatedMasterEnabled",
        .dedicated_master_type = "DedicatedMasterType",
        .instance_count = "InstanceCount",
        .instance_type = "InstanceType",
        .warm_count = "WarmCount",
        .warm_enabled = "WarmEnabled",
        .warm_type = "WarmType",
        .zone_awareness_config = "ZoneAwarenessConfig",
        .zone_awareness_enabled = "ZoneAwarenessEnabled",
    };
};
