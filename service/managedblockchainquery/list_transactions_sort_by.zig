pub const ListTransactionsSortBy = enum {
    /// Timestamp of a transaction
    transaction_timestamp,

    pub const json_field_names = .{
        .transaction_timestamp = "TRANSACTION_TIMESTAMP",
    };
};
