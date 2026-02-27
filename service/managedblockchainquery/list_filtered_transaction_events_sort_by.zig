pub const ListFilteredTransactionEventsSortBy = enum {
    /// Timestamp of a transaction
    blockchain_instant,

    pub const json_field_names = .{
        .blockchain_instant = "blockchainInstant",
    };
};
