/// Specifies an S3 Inventory filter. The inventory only includes objects that
/// meet the filter's
/// criteria.
pub const InventoryFilter = struct {
    /// The prefix that an object must have to be included in the inventory results.
    prefix: []const u8,
};
