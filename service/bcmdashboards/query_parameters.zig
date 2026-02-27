const CostAndUsageQuery = @import("cost_and_usage_query.zig").CostAndUsageQuery;
const ReservationCoverageQuery = @import("reservation_coverage_query.zig").ReservationCoverageQuery;
const ReservationUtilizationQuery = @import("reservation_utilization_query.zig").ReservationUtilizationQuery;
const SavingsPlansCoverageQuery = @import("savings_plans_coverage_query.zig").SavingsPlansCoverageQuery;
const SavingsPlansUtilizationQuery = @import("savings_plans_utilization_query.zig").SavingsPlansUtilizationQuery;

/// Defines the data retrieval parameters for a widget.
pub const QueryParameters = union(enum) {
    /// The parameters for querying cost and usage data, including metrics, time
    /// range, granularity, grouping dimensions, and filters.
    cost_and_usage: ?CostAndUsageQuery,
    /// The parameters for querying Reserved Instance coverage data, showing how
    /// much of your eligible instance usage is covered by Reserved Instances.
    reservation_coverage: ?ReservationCoverageQuery,
    /// The parameters for querying Reserved Instance utilization data, showing how
    /// effectively your Reserved Instances are being used.
    reservation_utilization: ?ReservationUtilizationQuery,
    /// The parameters for querying Savings Plans coverage data, showing how much of
    /// your eligible compute usage is covered by Savings Plans.
    savings_plans_coverage: ?SavingsPlansCoverageQuery,
    /// The parameters for querying Savings Plans utilization data, showing how
    /// effectively your Savings Plans are being used.
    savings_plans_utilization: ?SavingsPlansUtilizationQuery,

    pub const json_field_names = .{
        .cost_and_usage = "costAndUsage",
        .reservation_coverage = "reservationCoverage",
        .reservation_utilization = "reservationUtilization",
        .savings_plans_coverage = "savingsPlansCoverage",
        .savings_plans_utilization = "savingsPlansUtilization",
    };
};
