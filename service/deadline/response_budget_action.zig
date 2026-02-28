const BudgetActionType = @import("budget_action_type.zig").BudgetActionType;

/// The details of a budget action.
pub const ResponseBudgetAction = struct {
    /// The budget action description.
    ///
    /// This field can store any content. Escape or encode this content before
    /// displaying it on a webpage or any other system that might interpret the
    /// content of this field.
    description: ?[]const u8,

    /// The percentage threshold for the budget.
    threshold_percentage: f32,

    /// The action taken on the budget once scheduling stops.
    @"type": BudgetActionType,

    pub const json_field_names = .{
        .description = "description",
        .threshold_percentage = "thresholdPercentage",
        .@"type" = "type",
    };
};
