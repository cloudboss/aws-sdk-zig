const InventoryFilter = @import("inventory_filter.zig").InventoryFilter;

/// A user-defined set of one or more filters on which to aggregate inventory
/// data. Groups
/// return a count of resources that match and don't match the specified
/// criteria.
pub const InventoryGroup = struct {
    /// Filters define the criteria for the group. The `matchingCount` field
    /// displays the
    /// number of resources that match the criteria. The `notMatchingCount` field
    /// displays the
    /// number of resources that don't match the criteria.
    filters: []const InventoryFilter,

    /// The name of the group.
    name: []const u8,

    pub const json_field_names = .{
        .filters = "Filters",
        .name = "Name",
    };
};
