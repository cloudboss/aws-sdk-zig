const CacheNodeUpdateStatus = @import("cache_node_update_status.zig").CacheNodeUpdateStatus;
const NodeGroupUpdateStatus = @import("node_group_update_status.zig").NodeGroupUpdateStatus;
const ServiceUpdateSeverity = @import("service_update_severity.zig").ServiceUpdateSeverity;
const ServiceUpdateStatus = @import("service_update_status.zig").ServiceUpdateStatus;
const ServiceUpdateType = @import("service_update_type.zig").ServiceUpdateType;
const SlaMet = @import("sla_met.zig").SlaMet;
const UpdateActionStatus = @import("update_action_status.zig").UpdateActionStatus;

/// The status of the service update for a specific replication group
pub const UpdateAction = struct {
    /// The ID of the cache cluster
    cache_cluster_id: ?[]const u8,

    /// The status of the service update on the cache node
    cache_node_update_status: ?[]const CacheNodeUpdateStatus,

    /// The Elasticache engine to which the update applies. Either Valkey, Redis OSS
    /// or Memcached.
    engine: ?[]const u8,

    /// The estimated length of time for the update to complete
    estimated_update_time: ?[]const u8,

    /// The status of the service update on the node group
    node_group_update_status: ?[]const NodeGroupUpdateStatus,

    /// The progress of the service update on the replication group
    nodes_updated: ?[]const u8,

    /// The ID of the replication group
    replication_group_id: ?[]const u8,

    /// The unique ID of the service update
    service_update_name: ?[]const u8,

    /// The recommended date to apply the service update to ensure compliance. For
    /// information
    /// on compliance, see [Self-Service Security Updates for
    /// Compliance](https://docs.aws.amazon.com/AmazonElastiCache/latest/dg/elasticache-compliance.html#elasticache-compliance-self-service).
    service_update_recommended_apply_by_date: ?i64,

    /// The date the update is first available
    service_update_release_date: ?i64,

    /// The severity of the service update
    service_update_severity: ?ServiceUpdateSeverity,

    /// The status of the service update
    service_update_status: ?ServiceUpdateStatus,

    /// Reflects the nature of the service update
    service_update_type: ?ServiceUpdateType,

    /// If yes, all nodes in the replication group have been updated by the
    /// recommended
    /// apply-by date. If no, at least one node in the replication group have not
    /// been updated
    /// by the recommended apply-by date. If N/A, the replication group was created
    /// after the
    /// recommended apply-by date.
    sla_met: ?SlaMet,

    /// The date that the service update is available to a replication group
    update_action_available_date: ?i64,

    /// The status of the update action
    update_action_status: ?UpdateActionStatus,

    /// The date when the UpdateActionStatus was last modified
    update_action_status_modified_date: ?i64,
};
