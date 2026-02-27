const Order = @import("order.zig").Order;

/// A structured set of sort terms.
pub const Sort = struct {
    /// Unique identifier of a field.
    field_id: []const u8,

    /// A structured set of sort terms
    sort_order: Order,

    pub const json_field_names = .{
        .field_id = "fieldId",
        .sort_order = "sortOrder",
    };
};
