const FixedBudgetSchedule = @import("fixed_budget_schedule.zig").FixedBudgetSchedule;

/// The start and end time of the budget.
pub const BudgetSchedule = union(enum) {
    /// The fixed start and end time of the budget's schedule.
    fixed: ?FixedBudgetSchedule,

    pub const json_field_names = .{
        .fixed = "fixed",
    };
};
