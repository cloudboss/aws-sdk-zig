const RouteTollPriceValueRange = @import("route_toll_price_value_range.zig").RouteTollPriceValueRange;

/// The toll price.
pub const RouteTollPrice = struct {
    /// Currency code corresponding to the price. This is the same as Currency
    /// specified in the request.
    currency: []const u8,

    /// If the price is an estimate or an exact value.
    estimate: bool,

    /// Duration for which the price corresponds to.
    ///
    /// **Unit**: `seconds`
    per_duration: i64 = 0,

    /// If the price is a range or an exact value. If any of the toll fares making
    /// up the route is a range, the overall price is also a range.
    range: bool,

    /// Price range with a minimum and maximum value, if a range.
    range_value: ?RouteTollPriceValueRange = null,

    /// Exact price, if not a range.
    value: f64,

    pub const json_field_names = .{
        .currency = "Currency",
        .estimate = "Estimate",
        .per_duration = "PerDuration",
        .range = "Range",
        .range_value = "RangeValue",
        .value = "Value",
    };
};
