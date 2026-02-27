const BuiltInSlotTypeSortAttribute = @import("built_in_slot_type_sort_attribute.zig").BuiltInSlotTypeSortAttribute;
const SortOrder = @import("sort_order.zig").SortOrder;

/// Specifies attributes for sorting a list of built-in slot
/// types.
pub const BuiltInSlotTypeSortBy = struct {
    /// The attribute to use to sort the list of built-in intents.
    attribute: BuiltInSlotTypeSortAttribute,

    /// The order to sort the list. You can choose ascending or
    /// descending.
    order: SortOrder,

    pub const json_field_names = .{
        .attribute = "attribute",
        .order = "order",
    };
};
