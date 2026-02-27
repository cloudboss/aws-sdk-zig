const SlotTypeSortAttribute = @import("slot_type_sort_attribute.zig").SlotTypeSortAttribute;
const SortOrder = @import("sort_order.zig").SortOrder;

/// Specifies attributes for sorting a list of slot types.
pub const SlotTypeSortBy = struct {
    /// The attribute to use to sort the list of slot types.
    attribute: SlotTypeSortAttribute,

    /// The order to sort the list. You can say ascending or
    /// descending.
    order: SortOrder,

    pub const json_field_names = .{
        .attribute = "attribute",
        .order = "order",
    };
};
