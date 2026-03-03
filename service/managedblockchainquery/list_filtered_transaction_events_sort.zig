const ListFilteredTransactionEventsSortBy = @import("list_filtered_transaction_events_sort_by.zig").ListFilteredTransactionEventsSortBy;
const SortOrder = @import("sort_order.zig").SortOrder;

/// Lists all the transaction events for an address on the blockchain.
///
/// This operation is only supported on the Bitcoin blockchain networks.
pub const ListFilteredTransactionEventsSort = struct {
    /// Container on how the results will be sorted by?
    sort_by: ?ListFilteredTransactionEventsSortBy = null,

    /// The container for the *sort order* for `ListFilteredTransactionEvents`.
    /// The `SortOrder` field only accepts the values `ASCENDING`
    /// and `DESCENDING`. Not providing `SortOrder` will default
    /// to `ASCENDING`.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .sort_by = "sortBy",
        .sort_order = "sortOrder",
    };
};
