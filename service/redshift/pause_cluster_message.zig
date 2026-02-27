/// Describes a pause cluster operation. For example, a scheduled action to run
/// the `PauseCluster` API operation.
pub const PauseClusterMessage = struct {
    /// The identifier of the cluster to be paused.
    cluster_identifier: []const u8,
};
