const BudgetParameter = @import("budget_parameter.zig").BudgetParameter;

/// Input parameters for privacy budget templates that support access budgets
/// functionality, enabling enhanced budget management capabilities.
pub const AccessBudgetsPrivacyTemplateParametersInput = struct {
    /// An array of budget parameters that define the access budget configuration
    /// for the privacy template.
    budget_parameters: []const BudgetParameter,

    /// The Amazon Resource Name (ARN) of the resource associated with this privacy
    /// budget template.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .budget_parameters = "budgetParameters",
        .resource_arn = "resourceArn",
    };
};
