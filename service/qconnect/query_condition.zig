const QueryConditionItem = @import("query_condition_item.zig").QueryConditionItem;

/// Information about how to query content.
pub const QueryCondition = union(enum) {
    /// The condition for the query.
    single: ?QueryConditionItem,

    pub const json_field_names = .{
        .single = "single",
    };
};
