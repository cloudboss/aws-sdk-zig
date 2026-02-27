const InventoryFilterCondition = @import("inventory_filter_condition.zig").InventoryFilterCondition;

/// An inventory filter.
pub const InventoryFilter = struct {
    /// Condition of the filter.
    condition: InventoryFilterCondition,

    /// Name of the filter.
    name: []const u8,

    /// Value of the filter.
    value: ?[]const u8,

    pub const json_field_names = .{
        .condition = "Condition",
        .name = "Name",
        .value = "Value",
    };
};
