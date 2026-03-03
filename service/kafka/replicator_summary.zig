const KafkaClusterSummary = @import("kafka_cluster_summary.zig").KafkaClusterSummary;
const ReplicationInfoSummary = @import("replication_info_summary.zig").ReplicationInfoSummary;
const ReplicatorState = @import("replicator_state.zig").ReplicatorState;

/// Information about a replicator.
pub const ReplicatorSummary = struct {
    /// The time the replicator was created.
    creation_time: ?i64 = null,

    /// The current version of the replicator.
    current_version: ?[]const u8 = null,

    /// Whether this resource is a replicator reference.
    is_replicator_reference: ?bool = null,

    /// Kafka Clusters used in setting up sources / targets for replication.
    kafka_clusters_summary: ?[]const KafkaClusterSummary = null,

    /// A list of summarized information of replications between clusters.
    replication_info_summary_list: ?[]const ReplicationInfoSummary = null,

    /// The Amazon Resource Name (ARN) of the replicator.
    replicator_arn: ?[]const u8 = null,

    /// The name of the replicator.
    replicator_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the replicator resource in the region
    /// where the replicator was created.
    replicator_resource_arn: ?[]const u8 = null,

    /// State of the replicator.
    replicator_state: ?ReplicatorState = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .current_version = "CurrentVersion",
        .is_replicator_reference = "IsReplicatorReference",
        .kafka_clusters_summary = "KafkaClustersSummary",
        .replication_info_summary_list = "ReplicationInfoSummaryList",
        .replicator_arn = "ReplicatorArn",
        .replicator_name = "ReplicatorName",
        .replicator_resource_arn = "ReplicatorResourceArn",
        .replicator_state = "ReplicatorState",
    };
};
