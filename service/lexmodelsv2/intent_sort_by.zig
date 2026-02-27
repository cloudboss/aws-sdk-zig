const IntentSortAttribute = @import("intent_sort_attribute.zig").IntentSortAttribute;
const SortOrder = @import("sort_order.zig").SortOrder;

/// Specifies attributes for sorting a list of intents.
pub const IntentSortBy = struct {
    /// The attribute to use to sort the list of intents.
    attribute: IntentSortAttribute,

    /// The order to sort the list. You can choose ascending or
    /// descending.
    order: SortOrder,

    pub const json_field_names = .{
        .attribute = "attribute",
        .order = "order",
    };
};
