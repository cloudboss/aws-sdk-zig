const SnapshotAttributeToSortBy = @import("snapshot_attribute_to_sort_by.zig").SnapshotAttributeToSortBy;
const SortByOrder = @import("sort_by_order.zig").SortByOrder;

/// Describes a sorting entity
pub const SnapshotSortingEntity = struct {
    /// The category for sorting the snapshots.
    attribute: SnapshotAttributeToSortBy,

    /// The order for listing the attributes.
    sort_order: ?SortByOrder = null,
};
