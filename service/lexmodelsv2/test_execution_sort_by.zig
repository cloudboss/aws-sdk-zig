const TestExecutionSortAttribute = @import("test_execution_sort_attribute.zig").TestExecutionSortAttribute;
const SortOrder = @import("sort_order.zig").SortOrder;

/// Contains information about the method by which to sort the instances of
/// test executions you have carried out.
pub const TestExecutionSortBy = struct {
    /// Specifies whether to sort the test set executions by the date and time at
    /// which the test sets were created.
    attribute: TestExecutionSortAttribute,

    /// Specifies whether to sort in ascending or descending order.
    order: SortOrder,

    pub const json_field_names = .{
        .attribute = "attribute",
        .order = "order",
    };
};
