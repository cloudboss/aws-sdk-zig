const TransactionDescription = @import("transaction_description.zig").TransactionDescription;

pub const ListTransactionsResponse = struct {
    /// A continuation token indicating whether additional data is available.
    next_token: ?[]const u8 = null,

    /// A list of transactions. The record for each transaction is a
    /// `TransactionDescription` object.
    transactions: ?[]const TransactionDescription = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .transactions = "Transactions",
    };
};
