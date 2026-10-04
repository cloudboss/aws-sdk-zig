const SortOrder = @import("sort_order.zig").SortOrder;

/// An object that contains the `SortBy` and `SortOrder` attributes.
pub const Sort = struct {
    /// The attribute on which the data is grouped, which can be `EndTime`,
    /// `StartTime`, or `LastUpdateTime`. `StartTime` and `LastUpdateTime` are
    /// supported only when `PartyType` is `Proposer`. The default value is
    /// `EndTime`.
    sort_by: ?[]const u8 = null,

    /// The sorting order, which can be `ASCENDING` or `DESCENDING`. The default
    /// value is `ASCENDING`.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .sort_by = "sortBy",
        .sort_order = "sortOrder",
    };
};
