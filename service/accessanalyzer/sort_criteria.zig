const OrderBy = @import("order_by.zig").OrderBy;

/// The criteria used to sort.
pub const SortCriteria = struct {
    /// The name of the attribute to sort on.
    attribute_name: ?[]const u8 = null,

    /// The sort order, ascending or descending.
    order_by: ?OrderBy = null,

    pub const json_field_names = .{
        .attribute_name = "attributeName",
        .order_by = "orderBy",
    };
};
