const SortOrder = @import("sort_order.zig").SortOrder;

/// The details of the way to sort search results.
pub const SearchSort = struct {
    /// The attribute detail of the way to sort search results.
    attribute: []const u8,

    /// The order detail of the wya to sort search results.
    order: ?SortOrder = null,

    pub const json_field_names = .{
        .attribute = "attribute",
        .order = "order",
    };
};
