const BudgetActionType = @import("budget_action_type.zig").BudgetActionType;

/// The budget action to add.
pub const BudgetActionToAdd = struct {
    /// A description for the budget action to add.
    ///
    /// This field can store any content. Escape or encode this content before
    /// displaying it on a webpage or any other system that might interpret the
    /// content of this field.
    description: ?[]const u8,

    /// The percentage threshold for the budget action to add.
    threshold_percentage: f32,

    /// The type of budget action to add.
    type: BudgetActionType,

    pub const json_field_names = .{
        .description = "description",
        .threshold_percentage = "thresholdPercentage",
        .type = "type",
    };
};
