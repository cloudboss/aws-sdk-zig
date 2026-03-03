const Order = @import("order.zig").Order;

/// Filter criteria that orders the return output. It can be sorted in ascending
/// or
/// descending order.
pub const OrderBy = struct {
    /// The set order that filters results.
    order: ?Order = null,

    /// The property name.
    property_name: []const u8,

    pub const json_field_names = .{
        .order = "order",
        .property_name = "propertyName",
    };
};
