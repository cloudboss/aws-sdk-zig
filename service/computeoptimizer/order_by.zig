const Dimension = @import("dimension.zig").Dimension;
const Order = @import("order.zig").Order;

/// Describes how the recommendations are ordered.
pub const OrderBy = struct {
    /// The dimension values to sort the recommendations.
    dimension: ?Dimension,

    /// The order to sort the recommendations.
    order: ?Order,

    pub const json_field_names = .{
        .dimension = "dimension",
        .order = "order",
    };
};
