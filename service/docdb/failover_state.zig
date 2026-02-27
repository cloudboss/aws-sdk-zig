const FailoverStatus = @import("failover_status.zig").FailoverStatus;

/// Contains the state of scheduled or in-process operations on an Amazon
/// DocumentDB global cluster.
/// This data type is empty unless a switchover or failover operation is
/// scheduled or is in progress on the global cluster.
pub const FailoverState = struct {
    /// The Amazon Resource Name (ARN) of the Amazon DocumentDB cluster that is
    /// currently being demoted, and which is associated with this state.
    from_db_cluster_arn: ?[]const u8,

    /// Indicates whether the operation is a global switchover or a global failover.
    /// If data loss is allowed, then the operation is a global failover. Otherwise,
    /// it's a switchover.
    is_data_loss_allowed: ?bool,

    /// The current status of the global cluster. Possible values are as follows:
    ///
    /// * **pending** – The service received a request to switch over or fail over
    ///   the global cluster.
    /// The global cluster's primary cluster and the specified secondary cluster are
    /// being verified before the operation starts.
    ///
    /// * **failing-over** – The chosen secondary cluster is being promoted to
    ///   become the new primary cluster to fail over the global cluster.
    ///
    /// * **cancelling** – The request to switch over or fail over the global
    ///   cluster was cancelled and the primary cluster and the selected secondary
    ///   cluster are returning to their previous states.
    status: ?FailoverStatus,

    /// The Amazon Resource Name (ARN) of the Amazon DocumentDB cluster that is
    /// currently being promoted, and which is associated with this state.
    to_db_cluster_arn: ?[]const u8,
};
