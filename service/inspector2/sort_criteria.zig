const SortField = @import("sort_field.zig").SortField;
const SortOrder = @import("sort_order.zig").SortOrder;

/// Details about the criteria used to sort finding results.
pub const SortCriteria = struct {
    /// The finding detail field by which results are sorted.
    field: SortField,

    /// The order by which findings are sorted.
    sort_order: SortOrder,

    pub const json_field_names = .{
        .field = "field",
        .sort_order = "sortOrder",
    };
};
