const AutoRefreshMode = @import("auto_refresh_mode.zig").AutoRefreshMode;
const AccessBudgetType = @import("access_budget_type.zig").AccessBudgetType;

/// Detailed information about an access budget including time bounds, budget
/// allocation, and configuration settings.
pub const AccessBudgetDetails = struct {
    /// Indicates whether the budget automatically refreshes for each time period
    /// specified in `budgetType`. Valid values are:
    ///
    /// `ENABLED` - The budget refreshes automatically at the start of each period.
    ///
    /// `DISABLED` - The budget must be refreshed manually.
    ///
    /// `NULL` - The value is null when `budgetType` is set to `LIFETIME`.
    auto_refresh: ?AutoRefreshMode = null,

    /// The total budget allocation amount for this access budget.
    budget: i32,

    /// Specifies the time period for limiting table usage in queries and jobs. For
    /// calendar-based periods, the budget can renew if auto refresh is enabled. For
    /// lifetime budgets, the limit applies to the total usage throughout the
    /// collaboration. Valid values are:
    ///
    /// `CALENDAR_DAY` - Limit table usage per day.
    ///
    /// `CALENDAR_WEEK` - Limit table usage per week.
    ///
    /// `CALENDAR_MONTH` - Limit table usage per month.
    ///
    /// `LIFETIME` - Limit total table usage for the collaboration duration.
    budget_type: AccessBudgetType,

    /// The end time for the access budget period.
    end_time: ?i64 = null,

    /// The remaining budget amount available for use within this access budget.
    remaining_budget: i32,

    /// The start time for the access budget period.
    start_time: i64,

    pub const json_field_names = .{
        .auto_refresh = "autoRefresh",
        .budget = "budget",
        .budget_type = "budgetType",
        .end_time = "endTime",
        .remaining_budget = "remainingBudget",
        .start_time = "startTime",
    };
};
