const BotLocaleSortAttribute = @import("bot_locale_sort_attribute.zig").BotLocaleSortAttribute;
const SortOrder = @import("sort_order.zig").SortOrder;

/// Specifies attributes for sorting a list of bot locales.
pub const BotLocaleSortBy = struct {
    /// The bot locale attribute to sort by.
    attribute: BotLocaleSortAttribute,

    /// Specifies whether to sort the bot locales in ascending or descending
    /// order.
    order: SortOrder,

    pub const json_field_names = .{
        .attribute = "attribute",
        .order = "order",
    };
};
