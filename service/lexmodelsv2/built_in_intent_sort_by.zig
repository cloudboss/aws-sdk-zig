const BuiltInIntentSortAttribute = @import("built_in_intent_sort_attribute.zig").BuiltInIntentSortAttribute;
const SortOrder = @import("sort_order.zig").SortOrder;

/// Specifies attributes for sorting a list of built-in intents.
pub const BuiltInIntentSortBy = struct {
    /// The attribute to use to sort the list of built-in intents.
    attribute: BuiltInIntentSortAttribute,

    /// The order to sort the list. You can specify ascending or descending
    /// order.
    order: SortOrder,

    pub const json_field_names = .{
        .attribute = "attribute",
        .order = "order",
    };
};
