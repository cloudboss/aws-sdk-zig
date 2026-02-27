const EstimatedMonthlySavings = @import("estimated_monthly_savings.zig").EstimatedMonthlySavings;

/// Aggregate totals for automation events, including counts and estimated
/// savings.
pub const SummaryTotals = struct {
    /// The total number of automation events in this summary group.
    automation_event_count: ?i32,

    estimated_monthly_savings: ?EstimatedMonthlySavings,

    pub const json_field_names = .{
        .automation_event_count = "automationEventCount",
        .estimated_monthly_savings = "estimatedMonthlySavings",
    };
};
