const AccessBudgetDetails = @import("access_budget_details.zig").AccessBudgetDetails;

/// Controls and tracks usage limits for associated configured tables within a
/// collaboration across queries and job. Supports both period-based budgets
/// that can renew (daily, weekly, or monthly) and fixed lifetime budgets.
/// Contains the resource ARN, remaining budget information, and up to two
/// budget configurations (period-based and lifetime). By default, table usage
/// is unlimited unless a budget is configured.
pub const AccessBudget = struct {
    /// The total remaining budget across all budget parameters, showing the lower
    /// value between the per-period budget and lifetime budget for this access
    /// budget. For individual parameter budgets, see `remainingBudget`.
    aggregate_remaining_budget: i32,

    /// Detailed budget information including time bounds, remaining budget, and
    /// refresh settings.
    details: []const AccessBudgetDetails,

    /// The Amazon Resource Name (ARN) of the access budget resource.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .aggregate_remaining_budget = "aggregateRemainingBudget",
        .details = "details",
        .resource_arn = "resourceArn",
    };
};
