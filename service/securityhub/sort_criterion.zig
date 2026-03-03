const SortOrder = @import("sort_order.zig").SortOrder;

/// A collection of finding attributes used to sort findings.
pub const SortCriterion = struct {
    /// The finding attribute used to sort findings.
    field: ?[]const u8 = null,

    /// The order used to sort findings.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .field = "Field",
        .sort_order = "SortOrder",
    };
};
