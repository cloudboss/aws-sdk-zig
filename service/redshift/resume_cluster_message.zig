/// Describes a resume cluster operation. For example, a scheduled action to run
/// the `ResumeCluster` API operation.
pub const ResumeClusterMessage = struct {
    /// The identifier of the cluster to be resumed.
    cluster_identifier: []const u8,
};
