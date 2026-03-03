/// Either a count, remaining count, or a version number in a delete inventory
/// summary.
pub const InventoryDeletionSummaryItem = struct {
    /// A count of the number of deleted items.
    count: i32 = 0,

    /// The remaining number of items to delete.
    remaining_count: i32 = 0,

    /// The inventory type version.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .count = "Count",
        .remaining_count = "RemainingCount",
        .version = "Version",
    };
};
