const SortOrder = @import("sort_order.zig").SortOrder;

/// Organizes parameters according to your specifications.
pub const ParameterSortExpression = struct {
    /// The parameter name to sort by.
    name: []const u8,

    /// The sort order for the parameter.
    sort_order: SortOrder,

    pub const json_field_names = .{
        .name = "name",
        .sort_order = "sortOrder",
    };
};
