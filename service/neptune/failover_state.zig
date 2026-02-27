const FailoverStatus = @import("failover_status.zig").FailoverStatus;

/// Contains the state of scheduled or in-process operations on a
/// global cluster (Neptune global database). This data type is empty unless a
/// switchover
/// or failover operation is scheduled or is in progress on the Neptune global
/// database.
pub const FailoverState = struct {
    /// The Amazon Resource Name (ARN) of the Neptune DB cluster that is currently
    /// being demoted, and which is associated with this
    /// state.
    from_db_cluster_arn: ?[]const u8,

    /// Indicates whether the operation is a global switchover or a global failover.
    /// If data loss is allowed, then the operation is a global failover.
    /// Otherwise, it's a switchover.
    is_data_loss_allowed: ?bool,

    /// The current status of the global cluster. Possible values are as follows:
    ///
    /// * pending  The service received a request to switch over or fail over the
    ///   global cluster. The
    /// global cluster's primary DB cluster and the specified secondary DB cluster
    /// are being verified before the operation
    /// starts.
    ///
    /// * failing-over  Neptune is promoting the chosen secondary Neptune DB
    ///   cluster to become the new primary DB cluster to fail over the global
    ///   cluster.
    ///
    /// * cancelling  The request to switch over or fail over the global cluster
    ///   was cancelled and the primary
    /// Neptune DB cluster and the selected secondary Neptune DB cluster are
    /// returning to their previous states.
    ///
    /// * switching-over  This status covers the range of Neptune internal
    ///   operations that take place during the switchover process, such
    /// as demoting the primary Neptune DB cluster, promoting the secondary Neptune
    /// DB cluster, and synchronizing replicas.
    status: ?FailoverStatus,

    /// The Amazon Resource Name (ARN) of the Neptune DB cluster that is currently
    /// being promoted, and which is associated
    /// with this state.
    to_db_cluster_arn: ?[]const u8,
};
