const Spend = @import("spend.zig").Spend;
const TimePeriod = @import("time_period.zig").TimePeriod;

/// The amount of cost or usage that you created the budget for, compared to
/// your actual
/// costs or usage.
pub const BudgetedAndActualAmounts = struct {
    /// Your actual costs or usage for a budget period.
    actual_amount: ?Spend,

    /// The amount of cost or usage that you created the budget for.
    budgeted_amount: ?Spend,

    /// The time period that's covered by this budget comparison.
    time_period: ?TimePeriod,

    pub const json_field_names = .{
        .actual_amount = "ActualAmount",
        .budgeted_amount = "BudgetedAmount",
        .time_period = "TimePeriod",
    };
};
