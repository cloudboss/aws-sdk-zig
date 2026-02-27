const TransactionStatus = @import("transaction_status.zig").TransactionStatus;

/// A structure that contains information about a transaction.
pub const TransactionDescription = struct {
    /// The time when the transaction committed or aborted, if it is not currently
    /// active.
    transaction_end_time: ?i64,

    /// The ID of the transaction.
    transaction_id: ?[]const u8,

    /// The time when the transaction started.
    transaction_start_time: ?i64,

    /// A status of ACTIVE, COMMITTED, or ABORTED.
    transaction_status: ?TransactionStatus,

    pub const json_field_names = .{
        .transaction_end_time = "TransactionEndTime",
        .transaction_id = "TransactionId",
        .transaction_start_time = "TransactionStartTime",
        .transaction_status = "TransactionStatus",
    };
};
