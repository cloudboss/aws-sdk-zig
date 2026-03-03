const orderString = @import("order_string.zig").orderString;

/// A field and direction for ordered output.
pub const OrderByElement = struct {
    /// The field on which to order.
    field_name: []const u8,

    /// Ordering direction.
    sort_order: ?orderString = null,

    pub const json_field_names = .{
        .field_name = "fieldName",
        .sort_order = "sortOrder",
    };
};
