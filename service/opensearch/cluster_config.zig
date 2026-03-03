const ColdStorageOptions = @import("cold_storage_options.zig").ColdStorageOptions;
const OpenSearchPartitionInstanceType = @import("open_search_partition_instance_type.zig").OpenSearchPartitionInstanceType;
const NodeOption = @import("node_option.zig").NodeOption;
const OpenSearchWarmPartitionInstanceType = @import("open_search_warm_partition_instance_type.zig").OpenSearchWarmPartitionInstanceType;
const ZoneAwarenessConfig = @import("zone_awareness_config.zig").ZoneAwarenessConfig;

/// Container for the cluster configuration of an OpenSearch Service domain. For
/// more
/// information, see [Creating and
/// managing Amazon OpenSearch Service
/// domains](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/createupdatedomains.html).
pub const ClusterConfig = struct {
    /// Container for cold storage configuration options.
    cold_storage_options: ?ColdStorageOptions = null,

    /// Number of dedicated master nodes in the cluster. This number must be greater
    /// than 2
    /// and not 4, otherwise you receive a validation exception.
    dedicated_master_count: ?i32 = null,

    /// Indicates whether dedicated master nodes are enabled for the cluster.`True`
    /// if the cluster will use a dedicated master node.`False` if the cluster will
    /// not.
    dedicated_master_enabled: ?bool = null,

    /// OpenSearch Service instance type of the dedicated master nodes in the
    /// cluster.
    dedicated_master_type: ?OpenSearchPartitionInstanceType = null,

    /// Number of data nodes in the cluster. This number must be greater than 1,
    /// otherwise you
    /// receive a validation exception.
    instance_count: ?i32 = null,

    /// Instance type of data nodes in the cluster.
    instance_type: ?OpenSearchPartitionInstanceType = null,

    /// A boolean that indicates whether a multi-AZ domain is turned on with a
    /// standby AZ. For
    /// more information, see [Configuring a multi-AZ domain in Amazon OpenSearch
    /// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/managedomains-multiaz.html).
    multi_az_with_standby_enabled: ?bool = null,

    /// List of node options for the domain.
    node_options: ?[]const NodeOption = null,

    /// The number of warm nodes in the cluster.
    warm_count: ?i32 = null,

    /// Whether to enable warm storage for the cluster.
    warm_enabled: ?bool = null,

    /// The instance type for the cluster's warm nodes.
    warm_type: ?OpenSearchWarmPartitionInstanceType = null,

    /// Container for zone awareness configuration options. Only required if
    /// `ZoneAwarenessEnabled` is `true`.
    zone_awareness_config: ?ZoneAwarenessConfig = null,

    /// Indicates whether multiple Availability Zones are enabled. For more
    /// information, see
    /// [Configuring a multi-AZ domain in Amazon OpenSearch
    /// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/managedomains-multiaz.html).
    zone_awareness_enabled: ?bool = null,

    pub const json_field_names = .{
        .cold_storage_options = "ColdStorageOptions",
        .dedicated_master_count = "DedicatedMasterCount",
        .dedicated_master_enabled = "DedicatedMasterEnabled",
        .dedicated_master_type = "DedicatedMasterType",
        .instance_count = "InstanceCount",
        .instance_type = "InstanceType",
        .multi_az_with_standby_enabled = "MultiAZWithStandbyEnabled",
        .node_options = "NodeOptions",
        .warm_count = "WarmCount",
        .warm_enabled = "WarmEnabled",
        .warm_type = "WarmType",
        .zone_awareness_config = "ZoneAwarenessConfig",
        .zone_awareness_enabled = "ZoneAwarenessEnabled",
    };
};
