const KeyReplicationState = @import("key_replication_state.zig").KeyReplicationState;

/// Represents the replication status information for a key in a replication
/// region for [Multi-Region key
/// replication](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/keys-multi-region-replication.html).
///
/// This structure contains details about the current state of key replication,
/// including any status messages and operational information about the
/// replication process.
pub const ReplicationStatusType = struct {
    /// The current status of key replication in this Amazon Web Services Region.
    ///
    /// This field indicates whether the key replication is in progress, completed
    /// successfully, or has encountered an error. Possible values include states
    /// such as `SYNCRHONIZED`, `IN_PROGRESS`, `DELETE_IN_PROGRESS`, or `FAILED`.
    /// This provides visibility into the replication process for monitoring and
    /// troubleshooting purposes.
    status: KeyReplicationState,

    /// A message that provides additional information about the current replication
    /// status of the key.
    ///
    /// This field contains details about any issues or progress updates related to
    /// key replication operations. It may include information about replication
    /// failures, synchronization status, or other operational details.
    status_message: ?[]const u8,

    pub const json_field_names = .{
        .status = "Status",
        .status_message = "StatusMessage",
    };
};
