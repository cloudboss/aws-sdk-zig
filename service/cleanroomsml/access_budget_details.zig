const AutoRefreshMode = @import("auto_refresh_mode.zig").AutoRefreshMode;
const AccessBudgetType = @import("access_budget_type.zig").AccessBudgetType;

/// The detailed information for a specific budget period, including time
/// boundaries and budget amounts.
pub const AccessBudgetDetails = struct {
    /// Specifies whether this budget automatically refreshes when the current
    /// period ends.
    auto_refresh: ?AutoRefreshMode,

    /// The total budget amount allocated for this period.
    budget: i32,

    /// The type of budget period. Calendar-based types reset automatically at
    /// regular intervals, while LIFETIME budgets never reset.
    budget_type: AccessBudgetType,

    /// The end time of this budget period. If not specified, the budget period
    /// continues indefinitely.
    end_time: ?i64,

    /// The amount of budget remaining in this period.
    remaining_budget: i32,

    /// The start time of this budget period.
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
