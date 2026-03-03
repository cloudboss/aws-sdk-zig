/// Provides a list of status information for a DB instance.
pub const DBInstanceStatusInfo = struct {
    /// Details of the error if there is an error for the instance. If the instance
    /// is not in an
    /// error state, this value is blank.
    message: ?[]const u8 = null,

    /// Boolean value that is true if the instance is operating normally, or false
    /// if the instance
    /// is in an error state.
    normal: ?bool = null,

    /// Status of the DB instance. For a StatusType of read replica, the values can
    /// be
    /// replicating, error, stopped, or terminated.
    status: ?[]const u8 = null,

    /// This value is currently "read replication."
    status_type: ?[]const u8 = null,
};
