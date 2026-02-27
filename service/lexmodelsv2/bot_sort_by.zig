const BotSortAttribute = @import("bot_sort_attribute.zig").BotSortAttribute;
const SortOrder = @import("sort_order.zig").SortOrder;

/// Specifies attributes for sorting a list of bots.
pub const BotSortBy = struct {
    /// The attribute to use to sort the list of bots.
    attribute: BotSortAttribute,

    /// The order to sort the list. You can choose ascending or
    /// descending.
    order: SortOrder,

    pub const json_field_names = .{
        .attribute = "attribute",
        .order = "order",
    };
};
