const RouteTollPriceSummary = @import("route_toll_price_summary.zig").RouteTollPriceSummary;

/// The toll summary for the complete route.
pub const RouteTollSummary = struct {
    /// Total toll summary for the complete route. Total is the only summary
    /// available today.
    total: ?RouteTollPriceSummary,

    pub const json_field_names = .{
        .total = "Total",
    };
};
