const SortOrder = @import("sort_order.zig").SortOrder;

/// The field sorting order and name of the field.
pub const FieldSortExpression = struct {
    /// The name of the field.
    name: []const u8,

    /// The sort order for the field.
    sort_order: SortOrder,

    pub const json_field_names = .{
        .name = "name",
        .sort_order = "sortOrder",
    };
};
