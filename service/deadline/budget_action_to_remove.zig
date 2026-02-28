const BudgetActionType = @import("budget_action_type.zig").BudgetActionType;

/// The budget action to remove.
pub const BudgetActionToRemove = struct {
    /// The percentage threshold for the budget action to remove.
    threshold_percentage: f32,

    /// The type of budget action to remove.
    type: BudgetActionType,

    pub const json_field_names = .{
        .threshold_percentage = "thresholdPercentage",
        .type = "type",
    };
};
