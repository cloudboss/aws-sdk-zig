const NodegroupUpdateStrategies = @import("nodegroup_update_strategies.zig").NodegroupUpdateStrategies;

/// The node group update configuration. An Amazon EKS managed node group
/// updates by replacing
/// nodes with new nodes of newer AMI versions in parallel. You choose the
/// *maximum
/// unavailable* and the *update strategy*.
pub const NodegroupUpdateConfig = struct {
    /// The maximum number of nodes unavailable at once during a version update.
    /// Nodes are
    /// updated in parallel. This value or `maxUnavailablePercentage` is required to
    /// have a value.The maximum number is 100.
    max_unavailable: ?i32,

    /// The maximum percentage of nodes unavailable during a version update. This
    /// percentage
    /// of nodes are updated in parallel, up to 100 nodes at once. This value or
    /// `maxUnavailable` is required to have a value.
    max_unavailable_percentage: ?i32,

    /// The configuration for the behavior to follow during a node group version
    /// update of
    /// this managed node group. You choose between two possible strategies for
    /// replacing nodes
    /// during an [
    /// `UpdateNodegroupVersion`
    /// ](https://docs.aws.amazon.com/eks/latest/APIReference/API_UpdateNodegroupVersion.html) action.
    ///
    /// An Amazon EKS managed node group updates by replacing nodes with new nodes
    /// of newer AMI
    /// versions in parallel. The *update strategy* changes the managed node
    /// update behavior of the managed node group for each quantity. The
    /// *default* strategy has guardrails to protect you from
    /// misconfiguration and launches the new instances first, before terminating
    /// the old
    /// instances. The *minimal* strategy removes the guardrails and
    /// terminates the old instances before launching the new instances. This
    /// minimal strategy
    /// is useful in scenarios where you are constrained to resources or costs (for
    /// example,
    /// with hardware accelerators such as GPUs).
    update_strategy: ?NodegroupUpdateStrategies,

    pub const json_field_names = .{
        .max_unavailable = "maxUnavailable",
        .max_unavailable_percentage = "maxUnavailablePercentage",
        .update_strategy = "updateStrategy",
    };
};
