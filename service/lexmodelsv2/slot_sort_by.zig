const SlotSortAttribute = @import("slot_sort_attribute.zig").SlotSortAttribute;
const SortOrder = @import("sort_order.zig").SortOrder;

/// Specifies attributes for sorting a list of bots.
pub const SlotSortBy = struct {
    /// The attribute to use to sort the list.
    attribute: SlotSortAttribute,

    /// The order to sort the list. You can choose ascending or
    /// descending.
    order: SortOrder,

    pub const json_field_names = .{
        .attribute = "attribute",
        .order = "order",
    };
};
