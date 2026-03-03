const Currency = @import("currency.zig").Currency;
const PricingUnit = @import("pricing_unit.zig").PricingUnit;
const TimePeriod = @import("time_period.zig").TimePeriod;

/// An estimate that's associated with a time period.
pub const EstimateByTime = struct {
    /// The currency of the estimate in USD.
    currency: ?Currency = null,

    /// The unit of measurement that's used for the cost estimate.
    pricing_unit: ?PricingUnit = null,

    /// The period of time, in days, that an estimate covers. The period has a start
    /// date and an
    /// end date. The start date must come before the end date.
    time_period: ?TimePeriod = null,

    /// The number of pricing units used to calculate the total number of hours. For
    /// example, 1
    /// unit equals 1 hour.
    unit: ?f64 = null,

    /// The amount of cost or usage that's measured for the cost estimate.
    usage_cost: ?f64 = null,

    pub const json_field_names = .{
        .currency = "currency",
        .pricing_unit = "pricingUnit",
        .time_period = "timePeriod",
        .unit = "unit",
        .usage_cost = "usageCost",
    };
};
