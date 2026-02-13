const InventoryGroup = @import("inventory_group.zig").InventoryGroup;

/// Specifies the inventory type and attribute for the aggregation execution.
pub const InventoryAggregator = struct {
    /// Nested aggregators to further refine aggregation for an inventory type.
    aggregators: ?[]const InventoryAggregator,

    /// The inventory type and attribute name for aggregation.
    expression: ?[]const u8,

    /// A user-defined set of one or more filters on which to aggregate inventory
    /// data. Groups
    /// return a count of resources that match and don't match the specified
    /// criteria.
    groups: ?[]const InventoryGroup,

    pub const json_field_names = .{
        .aggregators = "Aggregators",
        .expression = "Expression",
        .groups = "Groups",
    };
};
