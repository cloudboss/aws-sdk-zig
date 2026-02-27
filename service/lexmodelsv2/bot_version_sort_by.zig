const BotVersionSortAttribute = @import("bot_version_sort_attribute.zig").BotVersionSortAttribute;
const SortOrder = @import("sort_order.zig").SortOrder;

/// Specifies attributes for sorting a list of bot versions.
pub const BotVersionSortBy = struct {
    /// The attribute to use to sort the list of versions.
    attribute: BotVersionSortAttribute,

    /// The order to sort the list. You can specify ascending or descending
    /// order.
    order: SortOrder,

    pub const json_field_names = .{
        .attribute = "attribute",
        .order = "order",
    };
};
