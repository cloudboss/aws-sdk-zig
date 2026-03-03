const Order = @import("order.zig").Order;

/// Defines how rows will be sorted in the response.
pub const OrderBy = struct {
    /// Sorts by dimension values.
    dimension: ?[]const u8 = null,

    /// The order that's used to sort the data.
    order: ?Order = null,

    pub const json_field_names = .{
        .dimension = "dimension",
        .order = "order",
    };
};
