const AutoRefreshMode = @import("auto_refresh_mode.zig").AutoRefreshMode;
const AccessBudgetType = @import("access_budget_type.zig").AccessBudgetType;

/// Individual budget parameter configuration that defines specific budget
/// allocation settings for access budgets.
pub const BudgetParameter = struct {
    /// Whether this individual budget parameter automatically refreshes when the
    /// budget period resets.
    auto_refresh: ?AutoRefreshMode,

    /// The budget allocation amount for this specific parameter.
    budget: i32,

    /// The type of budget parameter being configured.
    @"type": AccessBudgetType,

    pub const json_field_names = .{
        .auto_refresh = "autoRefresh",
        .budget = "budget",
        .@"type" = "type",
    };
};
