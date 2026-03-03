const TransactionStatusFilter = @import("transaction_status_filter.zig").TransactionStatusFilter;

pub const ListTransactionsRequest = struct {
    /// The catalog for which to list transactions. Defaults to the account ID of
    /// the caller.
    catalog_id: ?[]const u8 = null,

    /// The maximum number of transactions to return in a single call.
    max_results: ?i32 = null,

    /// A continuation token if this is not the first call to retrieve transactions.
    next_token: ?[]const u8 = null,

    /// A filter indicating the status of transactions to return. Options are ALL |
    /// COMPLETED | COMMITTED | ABORTED | ACTIVE. The default is `ALL`.
    status_filter: ?TransactionStatusFilter = null,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .status_filter = "StatusFilter",
    };
};
