const InventoryDeletionSummaryItem = @import("inventory_deletion_summary_item.zig").InventoryDeletionSummaryItem;

/// Information about the delete operation.
pub const InventoryDeletionSummary = struct {
    /// Remaining number of items to delete.
    remaining_count: ?i32,

    /// A list of counts and versions for deleted items.
    summary_items: ?[]const InventoryDeletionSummaryItem,

    /// The total number of items to delete. This count doesn't change during the
    /// delete
    /// operation.
    total_count: ?i32,

    pub const json_field_names = .{
        .remaining_count = "RemainingCount",
        .summary_items = "SummaryItems",
        .total_count = "TotalCount",
    };
};
