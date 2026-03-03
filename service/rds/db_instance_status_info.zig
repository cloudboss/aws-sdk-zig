/// Provides a list of status information for a DB instance.
pub const DBInstanceStatusInfo = struct {
    /// Details of the error if there is an error for the instance. If the instance
    /// isn't in an error state, this value is blank.
    message: ?[]const u8 = null,

    /// Indicates whether the instance is operating normally (TRUE) or is in an
    /// error state (FALSE).
    normal: ?bool = null,

    /// The status of the DB instance. For a StatusType of read replica, the values
    /// can be replicating, replication stop point set, replication stop point
    /// reached, error, stopped, or terminated.
    status: ?[]const u8 = null,

    /// This value is currently "read replication."
    status_type: ?[]const u8 = null,
};
