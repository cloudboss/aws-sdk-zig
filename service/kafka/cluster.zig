const aws = @import("aws");

const ClusterType = @import("cluster_type.zig").ClusterType;
const Provisioned = @import("provisioned.zig").Provisioned;
const Serverless = @import("serverless.zig").Serverless;
const ClusterState = @import("cluster_state.zig").ClusterState;
const StateInfo = @import("state_info.zig").StateInfo;

/// Returns information about a cluster.
pub const Cluster = struct {
    /// The Amazon Resource Name (ARN) that uniquely identifies a cluster operation.
    active_operation_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) that uniquely identifies the cluster.
    cluster_arn: ?[]const u8,

    /// The name of the cluster.
    cluster_name: ?[]const u8,

    /// Cluster Type.
    cluster_type: ?ClusterType,

    /// The time when the cluster was created.
    creation_time: ?i64,

    /// The current version of the MSK cluster.
    current_version: ?[]const u8,

    /// Information about the provisioned cluster.
    provisioned: ?Provisioned,

    /// Information about the serverless cluster.
    serverless: ?Serverless,

    /// The state of the cluster. The possible states are ACTIVE, CREATING,
    /// DELETING, FAILED, HEALING, MAINTENANCE, REBOOTING_BROKER, and UPDATING.
    state: ?ClusterState,

    /// State Info for the Amazon MSK cluster.
    state_info: ?StateInfo,

    /// Tags attached to the cluster.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .active_operation_arn = "ActiveOperationArn",
        .cluster_arn = "ClusterArn",
        .cluster_name = "ClusterName",
        .cluster_type = "ClusterType",
        .creation_time = "CreationTime",
        .current_version = "CurrentVersion",
        .provisioned = "Provisioned",
        .serverless = "Serverless",
        .state = "State",
        .state_info = "StateInfo",
        .tags = "Tags",
    };
};
