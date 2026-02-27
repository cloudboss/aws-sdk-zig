const aws = @import("aws");

const BudgetedAndActualAmounts = @import("budgeted_and_actual_amounts.zig").BudgetedAndActualAmounts;
const BudgetType = @import("budget_type.zig").BudgetType;
const CostTypes = @import("cost_types.zig").CostTypes;
const Expression = @import("expression.zig").Expression;
const Metric = @import("metric.zig").Metric;
const TimeUnit = @import("time_unit.zig").TimeUnit;

/// A history of the state of a budget at the end of the budget's specified time
/// period.
pub const BudgetPerformanceHistory = struct {
    /// The Amazon Resource Name (ARN) that uniquely identifies a specific billing
    /// view. The ARN is
    /// used to specify which particular billing view you want to interact with or
    /// retrieve
    /// information from when making API calls related to Amazon Web Services
    /// Billing and Cost
    /// Management features. The BillingViewArn can be retrieved by calling the
    /// ListBillingViews
    /// API.
    billing_view_arn: ?[]const u8,

    /// A list of amounts of cost or usage that you created budgets for, which are
    /// compared to
    /// your actual costs or usage.
    budgeted_and_actual_amounts_list: ?[]const BudgetedAndActualAmounts,

    budget_name: ?[]const u8,

    budget_type: ?BudgetType,

    /// The history of the cost filters for a budget during the specified time
    /// period.
    cost_filters: ?[]const aws.map.MapEntry([]const []const u8),

    /// The history of the cost types for a budget during the specified time period.
    cost_types: ?CostTypes,

    /// The filtering dimensions for the budget and their corresponding values.
    filter_expression: ?Expression,

    /// The definition for how the budget data is aggregated.
    metrics: ?[]const Metric,

    time_unit: ?TimeUnit,

    pub const json_field_names = .{
        .billing_view_arn = "BillingViewArn",
        .budgeted_and_actual_amounts_list = "BudgetedAndActualAmountsList",
        .budget_name = "BudgetName",
        .budget_type = "BudgetType",
        .cost_filters = "CostFilters",
        .cost_types = "CostTypes",
        .filter_expression = "FilterExpression",
        .metrics = "Metrics",
        .time_unit = "TimeUnit",
    };
};
