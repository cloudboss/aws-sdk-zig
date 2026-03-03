const Spend = @import("spend.zig").Spend;

/// The spend objects that are associated with this budget. The `actualSpend`
/// tracks how much you've used, cost, usage, RI units, or Savings Plans units
/// and the
/// `forecastedSpend` tracks how much that you're predicted to spend based on
/// your historical usage profile.
///
/// For example, if it's the 20th of the month and you have spent `50` dollars
/// on Amazon EC2, your `actualSpend` is `50 USD`, and your
/// `forecastedSpend` is `75 USD`.
pub const CalculatedSpend = struct {
    /// The amount of cost, usage, RI units, or Savings Plans units that you used.
    actual_spend: Spend,

    /// The amount of cost, usage, RI units, or Savings Plans units that you're
    /// forecasted to
    /// use.
    forecasted_spend: ?Spend = null,

    pub const json_field_names = .{
        .actual_spend = "ActualSpend",
        .forecasted_spend = "ForecastedSpend",
    };
};
