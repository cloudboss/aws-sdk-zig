const AwsOpenSearchServiceDomainClusterConfigZoneAwarenessConfigDetails = @import("aws_open_search_service_domain_cluster_config_zone_awareness_config_details.zig").AwsOpenSearchServiceDomainClusterConfigZoneAwarenessConfigDetails;

/// Details about the configuration of an OpenSearch cluster.
pub const AwsOpenSearchServiceDomainClusterConfigDetails = struct {
    /// The number of instances to use for the master node. If this attribute is
    /// specified, then `DedicatedMasterEnabled` must be `true`.
    dedicated_master_count: ?i32 = null,

    /// Whether to use a dedicated master node for the OpenSearch domain. A
    /// dedicated master node performs cluster management tasks, but does not hold
    /// data or respond to data upload requests.
    dedicated_master_enabled: ?bool = null,

    /// The hardware configuration of the computer that hosts the dedicated master
    /// node.
    ///
    /// If this attribute is specified, then `DedicatedMasterEnabled` must be
    /// `true`.
    dedicated_master_type: ?[]const u8 = null,

    /// The number of data nodes to use in the OpenSearch domain.
    instance_count: ?i32 = null,

    /// The instance type for your data nodes.
    ///
    /// For a list of valid values, see [Supported instance types in Amazon
    /// OpenSearch
    /// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/supported-instance-types.html) in the *Amazon OpenSearch Service Developer Guide*.
    instance_type: ?[]const u8 = null,

    /// The number of UltraWarm instances.
    warm_count: ?i32 = null,

    /// Whether UltraWarm is enabled.
    warm_enabled: ?bool = null,

    /// The type of UltraWarm instance.
    warm_type: ?[]const u8 = null,

    /// Configuration options for zone awareness. Provided if `ZoneAwarenessEnabled`
    /// is `true`.
    zone_awareness_config: ?AwsOpenSearchServiceDomainClusterConfigZoneAwarenessConfigDetails = null,

    /// Whether to enable zone awareness for the OpenSearch domain. When zone
    /// awareness is enabled, OpenSearch Service allocates the cluster's nodes and
    /// replica index shards across Availability Zones (AZs) in the same Region.
    /// This prevents data loss and minimizes downtime if a node or data center
    /// fails.
    zone_awareness_enabled: ?bool = null,

    pub const json_field_names = .{
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
