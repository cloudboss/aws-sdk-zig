const ErrorDetail = @import("error_detail.zig").ErrorDetail;
const ClusterState = @import("cluster_state.zig").ClusterState;
const ClusterStateChangeReason = @import("cluster_state_change_reason.zig").ClusterStateChangeReason;
const ClusterTimeline = @import("cluster_timeline.zig").ClusterTimeline;

/// The detailed status of the cluster.
pub const ClusterStatus = struct {
    /// A list of tuples that provides information about the errors that caused a
    /// cluster to
    /// terminate. This structure can contain up to 10 different `ErrorDetail`
    /// tuples.
    error_details: ?[]const ErrorDetail = null,

    /// The current state of the cluster.
    state: ?ClusterState = null,

    /// The reason for the cluster status change.
    state_change_reason: ?ClusterStateChangeReason = null,

    /// A timeline that represents the status of a cluster over the lifetime of the
    /// cluster.
    timeline: ?ClusterTimeline = null,

    pub const json_field_names = .{
        .error_details = "ErrorDetails",
        .state = "State",
        .state_change_reason = "StateChangeReason",
        .timeline = "Timeline",
    };
};
