const TestSetSortAttribute = @import("test_set_sort_attribute.zig").TestSetSortAttribute;
const SortOrder = @import("sort_order.zig").SortOrder;

/// Contains information about the methods by which to sort the test set.
pub const TestSetSortBy = struct {
    /// Specifies whether to sort the test sets by name or by the time they were
    /// last updated.
    attribute: TestSetSortAttribute,

    /// Specifies whether to sort in ascending or descending order.
    order: SortOrder,

    pub const json_field_names = .{
        .attribute = "attribute",
        .order = "order",
    };
};
