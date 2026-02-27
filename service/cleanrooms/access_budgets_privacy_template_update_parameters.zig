const BudgetParameter = @import("budget_parameter.zig").BudgetParameter;

/// Update parameters for privacy budget templates with access budgets
/// functionality, allowing modification of existing budget configurations.
pub const AccessBudgetsPrivacyTemplateUpdateParameters = struct {
    /// Updated array of budget parameters for the access budget configuration.
    budget_parameters: []const BudgetParameter,

    pub const json_field_names = .{
        .budget_parameters = "budgetParameters",
    };
};
