/// The dollar value of the anomaly.
pub const Impact = struct {
    /// The maximum dollar value that's observed for an anomaly.
    max_impact: f64 = 0,

    /// The cumulative dollar amount that was actually spent during the anomaly.
    total_actual_spend: ?f64,

    /// The cumulative dollar amount that was expected to be spent during the
    /// anomaly. It is
    /// calculated using advanced machine learning models to determine the typical
    /// spending
    /// pattern based on historical data for a customer.
    total_expected_spend: ?f64,

    /// The cumulative dollar difference between the total actual spend and total
    /// expected
    /// spend. It is calculated as `TotalActualSpend - TotalExpectedSpend`.
    total_impact: f64 = 0,

    /// The cumulative percentage difference between the total actual spend and
    /// total expected
    /// spend. It is calculated as `(TotalImpact / TotalExpectedSpend) * 100`. When
    /// `TotalExpectedSpend` is zero, this field is omitted. Expected spend can
    /// be zero in situations such as when you start to use a service for the first
    /// time.
    total_impact_percentage: ?f64,

    pub const json_field_names = .{
        .max_impact = "MaxImpact",
        .total_actual_spend = "TotalActualSpend",
        .total_expected_spend = "TotalExpectedSpend",
        .total_impact = "TotalImpact",
        .total_impact_percentage = "TotalImpactPercentage",
    };
};
