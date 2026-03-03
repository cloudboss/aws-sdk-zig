const aws = @import("aws");

const ClusterType = @import("cluster_type.zig").ClusterType;
const Provisioned = @import("provisioned.zig").Provisioned;
const Serverless = @import("serverless.zig").Serverless;
const ClusterState = @import("cluster_state.zig").ClusterState;
const StateInfo = @import("state_info.zig").StateInfo;

/// Returns information about a cluster.
pub const Cluster = struct {
    /// The Amazon Resource Name (ARN) that uniquely identifies a cluster operation.
    active_operation_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) that uniquely identifies the cluster.
    cluster_arn: ?[]const u8 = null,

    /// The name of the cluster.
    cluster_name: ?[]const u8 = null,

    /// Cluster Type.
    cluster_type: ?ClusterType = null,

    /// The time when the cluster was created.
    creation_time: ?i64 = null,

    /// The current version of the MSK cluster.
    current_version: ?[]const u8 = null,

    /// Information about the provisioned cluster.
    provisioned: ?Provisioned = null,

    /// Information about the serverless cluster.
    serverless: ?Serverless = null,

    /// The state of the cluster. The possible states are ACTIVE, CREATING,
    /// DELETING, FAILED, HEALING, MAINTENANCE, REBOOTING_BROKER, and UPDATING.
    state: ?ClusterState = null,

    /// State Info for the Amazon MSK cluster.
    state_info: ?StateInfo = null,

    /// Tags attached to the cluster.
    tags: ?[]const aws.map.StringMapEntry = null,

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
