const ForecastComputation = @import("forecast_computation.zig").ForecastComputation;
const GrowthRateComputation = @import("growth_rate_computation.zig").GrowthRateComputation;
const MaximumMinimumComputation = @import("maximum_minimum_computation.zig").MaximumMinimumComputation;
const MetricComparisonComputation = @import("metric_comparison_computation.zig").MetricComparisonComputation;
const PeriodOverPeriodComputation = @import("period_over_period_computation.zig").PeriodOverPeriodComputation;
const PeriodToDateComputation = @import("period_to_date_computation.zig").PeriodToDateComputation;
const TopBottomMoversComputation = @import("top_bottom_movers_computation.zig").TopBottomMoversComputation;
const TopBottomRankedComputation = @import("top_bottom_ranked_computation.zig").TopBottomRankedComputation;
const TotalAggregationComputation = @import("total_aggregation_computation.zig").TotalAggregationComputation;
const UniqueValuesComputation = @import("unique_values_computation.zig").UniqueValuesComputation;

/// The computation union that is used in an insight visual.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const Computation = struct {
    /// The forecast computation configuration.
    forecast: ?ForecastComputation,

    /// The growth rate computation configuration.
    growth_rate: ?GrowthRateComputation,

    /// The maximum and minimum computation configuration.
    maximum_minimum: ?MaximumMinimumComputation,

    /// The metric comparison computation configuration.
    metric_comparison: ?MetricComparisonComputation,

    /// The period over period computation configuration.
    period_over_period: ?PeriodOverPeriodComputation,

    /// The period to `DataSetIdentifier` computation configuration.
    period_to_date: ?PeriodToDateComputation,

    /// The top movers and bottom movers computation configuration.
    top_bottom_movers: ?TopBottomMoversComputation,

    /// The top ranked and bottom ranked computation configuration.
    top_bottom_ranked: ?TopBottomRankedComputation,

    /// The total aggregation computation configuration.
    total_aggregation: ?TotalAggregationComputation,

    /// The unique values computation configuration.
    unique_values: ?UniqueValuesComputation,

    pub const json_field_names = .{
        .forecast = "Forecast",
        .growth_rate = "GrowthRate",
        .maximum_minimum = "MaximumMinimum",
        .metric_comparison = "MetricComparison",
        .period_over_period = "PeriodOverPeriod",
        .period_to_date = "PeriodToDate",
        .top_bottom_movers = "TopBottomMovers",
        .top_bottom_ranked = "TopBottomRanked",
        .total_aggregation = "TotalAggregation",
        .unique_values = "UniqueValues",
    };
};
