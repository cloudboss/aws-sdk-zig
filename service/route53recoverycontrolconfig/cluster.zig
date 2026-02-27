const ClusterEndpoint = @import("cluster_endpoint.zig").ClusterEndpoint;
const NetworkType = @import("network_type.zig").NetworkType;
const Status = @import("status.zig").Status;

/// A set of five redundant Regional endpoints against which you can execute API
/// calls to update or get the state of routing controls. You can host multiple
/// control panels and routing controls on one cluster.
pub const Cluster = struct {
    /// The Amazon Resource Name (ARN) of the cluster.
    cluster_arn: ?[]const u8,

    /// Endpoints for a cluster. Specify one of these endpoints when you want to set
    /// or retrieve a routing control state in the cluster.
    ///
    /// To get or update the routing control state, see the Amazon Route 53
    /// Application Recovery Controller Routing Control Actions.
    cluster_endpoints: ?[]const ClusterEndpoint,

    /// The name of the cluster.
    name: ?[]const u8,

    /// The network type of the cluster. NetworkType can be one of the following:
    /// IPV4, DUALSTACK.
    network_type: ?NetworkType,

    /// The Amazon Web Services account ID of the cluster owner.
    owner: ?[]const u8,

    /// Deployment status of a resource. Status can be one of the following:
    /// PENDING, DEPLOYED, PENDING_DELETION.
    status: ?Status,

    pub const json_field_names = .{
        .cluster_arn = "ClusterArn",
        .cluster_endpoints = "ClusterEndpoints",
        .name = "Name",
        .network_type = "NetworkType",
        .owner = "Owner",
        .status = "Status",
    };
};
