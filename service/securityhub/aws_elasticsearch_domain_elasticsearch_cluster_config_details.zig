const AwsElasticsearchDomainElasticsearchClusterConfigZoneAwarenessConfigDetails = @import("aws_elasticsearch_domain_elasticsearch_cluster_config_zone_awareness_config_details.zig").AwsElasticsearchDomainElasticsearchClusterConfigZoneAwarenessConfigDetails;

/// details about the configuration of an OpenSearch cluster.
pub const AwsElasticsearchDomainElasticsearchClusterConfigDetails = struct {
    /// The number of instances to use for the master node. If this attribute is
    /// specified, then `DedicatedMasterEnabled` must be `true`.
    dedicated_master_count: ?i32,

    /// Whether to use a dedicated master node for the Elasticsearch domain. A
    /// dedicated master node performs cluster management tasks, but doesn't hold
    /// data or respond to data upload requests.
    dedicated_master_enabled: ?bool,

    /// The hardware configuration of the computer that hosts the dedicated master
    /// node. A sample value is `m3.medium.elasticsearch`. If this attribute is
    /// specified, then `DedicatedMasterEnabled` must be `true`.
    ///
    /// For a list of valid values, see [Supported instance types in Amazon
    /// OpenSearch
    /// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/supported-instance-types.html) in the *Amazon OpenSearch Service Developer Guide*.
    dedicated_master_type: ?[]const u8,

    /// The number of data nodes to use in the Elasticsearch domain.
    instance_count: ?i32,

    /// The instance type for your data nodes. For example,
    /// `m3.medium.elasticsearch`.
    ///
    /// For a list of valid values, see [Supported instance types in Amazon
    /// OpenSearch
    /// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/supported-instance-types.html) in the *Amazon OpenSearch Service Developer Guide*.
    instance_type: ?[]const u8,

    /// Configuration options for zone awareness. Provided if `ZoneAwarenessEnabled`
    /// is `true`.
    zone_awareness_config: ?AwsElasticsearchDomainElasticsearchClusterConfigZoneAwarenessConfigDetails,

    /// Whether to enable zone awareness for the Elasticsearch domain. When zone
    /// awareness is enabled, OpenSearch allocates the cluster's nodes and replica
    /// index shards across Availability Zones in the same Region. This prevents
    /// data loss and minimizes downtime if a node or data center fails.
    zone_awareness_enabled: ?bool,

    pub const json_field_names = .{
        .dedicated_master_count = "DedicatedMasterCount",
        .dedicated_master_enabled = "DedicatedMasterEnabled",
        .dedicated_master_type = "DedicatedMasterType",
        .instance_count = "InstanceCount",
        .instance_type = "InstanceType",
        .zone_awareness_config = "ZoneAwarenessConfig",
        .zone_awareness_enabled = "ZoneAwarenessEnabled",
    };
};
