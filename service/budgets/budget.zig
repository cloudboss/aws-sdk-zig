const aws = @import("aws");

const AutoAdjustData = @import("auto_adjust_data.zig").AutoAdjustData;
const Spend = @import("spend.zig").Spend;
const BudgetType = @import("budget_type.zig").BudgetType;
const CalculatedSpend = @import("calculated_spend.zig").CalculatedSpend;
const CostTypes = @import("cost_types.zig").CostTypes;
const Expression = @import("expression.zig").Expression;
const HealthStatus = @import("health_status.zig").HealthStatus;
const Metric = @import("metric.zig").Metric;
const TimePeriod = @import("time_period.zig").TimePeriod;
const TimeUnit = @import("time_unit.zig").TimeUnit;

/// Represents the output of the `CreateBudget` operation. The content consists
/// of the detailed metadata and data file information, and the current status
/// of the
/// `budget` object.
///
/// This is the Amazon Resource Name (ARN) pattern for a budget:
///
/// `arn:aws:budgets::AccountId:budget/budgetName`
pub const Budget = struct {
    /// The parameters that determine the budget amount for an auto-adjusting
    /// budget.
    auto_adjust_data: ?AutoAdjustData,

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

    /// The total amount of cost, usage, RI utilization, RI coverage, Savings Plans
    /// utilization, or Savings Plans coverage that you want to track with your
    /// budget.
    ///
    /// `BudgetLimit` is required for cost or usage budgets, but optional for RI or
    /// Savings Plans utilization or coverage budgets. RI and Savings Plans
    /// utilization or
    /// coverage budgets default to `100`. This is the only valid value for RI or
    /// Savings Plans utilization or coverage budgets. You can't use `BudgetLimit`
    /// with `PlannedBudgetLimits` for `CreateBudget` and
    /// `UpdateBudget` actions.
    budget_limit: ?Spend,

    /// The name of a budget. The name must be unique within an account. The `:`
    /// and `\` characters, and the "/action/" substring, aren't allowed in
    /// `BudgetName`.
    budget_name: []const u8,

    /// Specifies whether this budget tracks costs, usage, RI utilization, RI
    /// coverage,
    /// Savings Plans utilization, or Savings Plans coverage.
    budget_type: BudgetType,

    /// The actual and forecasted cost or usage that the budget tracks.
    calculated_spend: ?CalculatedSpend,

    /// The cost filters, such as `Region`, `Service`,
    /// `LinkedAccount`, `Tag`, or `CostCategory`, that are
    /// applied to a budget.
    ///
    /// Amazon Web Services Budgets supports the following services as a `Service`
    /// filter for RI budgets:
    ///
    /// * Amazon EC2
    ///
    /// * Amazon Redshift
    ///
    /// * Amazon Relational Database Service
    ///
    /// * Amazon ElastiCache
    ///
    /// * Amazon OpenSearch Service
    cost_filters: ?[]const aws.map.MapEntry([]const []const u8),

    /// The types of costs that are included in this `COST` budget.
    ///
    /// `USAGE`, `RI_UTILIZATION`, `RI_COVERAGE`,
    /// `SAVINGS_PLANS_UTILIZATION`, and `SAVINGS_PLANS_COVERAGE`
    /// budgets do not have `CostTypes`.
    cost_types: ?CostTypes,

    /// The filtering dimensions for the budget and their corresponding values.
    filter_expression: ?Expression,

    /// The current operational state of a Billing View derived resource.
    health_status: ?HealthStatus,

    /// The last time that you updated this budget.
    last_updated_time: ?i64,

    /// The definition for how the budget data is aggregated.
    metrics: ?[]const Metric,

    /// A map containing multiple `BudgetLimit`, including current or future
    /// limits.
    ///
    /// `PlannedBudgetLimits` is available for cost or usage budget and supports
    /// both monthly and quarterly `TimeUnit`.
    ///
    /// For monthly budgets, provide 12 months of `PlannedBudgetLimits` values.
    /// This must start from the current month and include the next 11 months. The
    /// `key` is the start of the month, `UTC` in epoch seconds.
    ///
    /// For quarterly budgets, provide four quarters of `PlannedBudgetLimits` value
    /// entries in standard calendar quarter increments. This must start from the
    /// current
    /// quarter and include the next three quarters. The `key` is the start of the
    /// quarter, `UTC` in epoch seconds.
    ///
    /// If the planned budget expires before 12 months for monthly or four quarters
    /// for
    /// quarterly, provide the `PlannedBudgetLimits` values only for the remaining
    /// periods.
    ///
    /// If the budget begins at a date in the future, provide `PlannedBudgetLimits`
    /// values from the start date of the budget.
    ///
    /// After all of the `BudgetLimit` values in `PlannedBudgetLimits`
    /// are used, the budget continues to use the last limit as the `BudgetLimit`.
    /// At
    /// that point, the planned budget provides the same experience as a fixed
    /// budget.
    ///
    /// `DescribeBudget` and `DescribeBudgets` response along with
    /// `PlannedBudgetLimits` also contain `BudgetLimit` representing
    /// the current month or quarter limit present in `PlannedBudgetLimits`. This
    /// only applies to budgets that are created with `PlannedBudgetLimits`. Budgets
    /// that are created without `PlannedBudgetLimits` only contain
    /// `BudgetLimit`. They don't contain
    /// `PlannedBudgetLimits`.
    planned_budget_limits: ?[]const aws.map.MapEntry(Spend),

    /// The period of time that's covered by a budget. You set the start date and
    /// end date. The
    /// start date must come before the end date. The end date must come before
    /// `06/15/87
    /// 00:00 UTC`.
    ///
    /// If you create your budget and don't specify a start date, Amazon Web
    /// Services defaults
    /// to the start of your chosen time period (DAILY, MONTHLY, QUARTERLY,
    /// ANNUALLY, or CUSTOM). For
    /// example, if you created your budget on January 24, 2018, chose `DAILY`, and
    /// didn't set a start date, Amazon Web Services set your start date to
    /// `01/24/18 00:00
    /// UTC`. If you chose `MONTHLY`, Amazon Web Services set your start
    /// date to `01/01/18 00:00 UTC`. If you didn't specify an end date, Amazon Web
    /// Services set your end date to `06/15/87 00:00 UTC`. The defaults are
    /// the same for the Billing and Cost Management console and the API.
    ///
    /// You can change either date with the `UpdateBudget` operation.
    ///
    /// After the end date, Amazon Web Services deletes the budget and all the
    /// associated
    /// notifications and subscribers.
    time_period: ?TimePeriod,

    /// The length of time until a budget resets the actual and forecasted spend.
    time_unit: TimeUnit,

    pub const json_field_names = .{
        .auto_adjust_data = "AutoAdjustData",
        .billing_view_arn = "BillingViewArn",
        .budget_limit = "BudgetLimit",
        .budget_name = "BudgetName",
        .budget_type = "BudgetType",
        .calculated_spend = "CalculatedSpend",
        .cost_filters = "CostFilters",
        .cost_types = "CostTypes",
        .filter_expression = "FilterExpression",
        .health_status = "HealthStatus",
        .last_updated_time = "LastUpdatedTime",
        .metrics = "Metrics",
        .planned_budget_limits = "PlannedBudgetLimits",
        .time_period = "TimePeriod",
        .time_unit = "TimeUnit",
    };
};
