const ListTransactionsSortBy = @import("list_transactions_sort_by.zig").ListTransactionsSortBy;
const SortOrder = @import("sort_order.zig").SortOrder;

/// The container for determining how the list transaction result will
/// be sorted.
pub const ListTransactionsSort = struct {
    /// Defaults to the value `TRANSACTION_TIMESTAMP`.
    sort_by: ?ListTransactionsSortBy = null,

    /// The container for the *sort order* for `ListTransactions`.
    /// The `SortOrder` field only accepts the values `ASCENDING`
    /// and `DESCENDING`. Not providing `SortOrder` will default
    /// to `ASCENDING`.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .sort_by = "sortBy",
        .sort_order = "sortOrder",
    };
};
