const SortOrder = @import("sort_order.zig").SortOrder;

/// The details for how to sort the data.
pub const SortDefinition = struct {
    /// The key that's used to sort the data.
    key: []const u8,

    /// The order that's used to sort the data.
    sort_order: ?SortOrder,

    pub const json_field_names = .{
        .key = "Key",
        .sort_order = "SortOrder",
    };
};
