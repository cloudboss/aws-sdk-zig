const OrderBy = @import("order_by.zig").OrderBy;

/// Contains information about the criteria used for sorting findings.
pub const SortCriteria = struct {
    /// Represents the finding attribute, such as `accountId`, that sorts the
    /// findings.
    attribute_name: ?[]const u8 = null,

    /// The order by which the sorted findings are to be displayed.
    order_by: ?OrderBy = null,

    pub const json_field_names = .{
        .attribute_name = "AttributeName",
        .order_by = "OrderBy",
    };
};
