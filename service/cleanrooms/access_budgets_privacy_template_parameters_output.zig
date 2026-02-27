const BudgetParameter = @import("budget_parameter.zig").BudgetParameter;

/// Output parameters for privacy budget templates with access budgets support,
/// containing the configured budget information.
pub const AccessBudgetsPrivacyTemplateParametersOutput = struct {
    /// An array of budget parameters returned from the access budget configuration.
    budget_parameters: []const BudgetParameter,

    /// The Amazon Resource Name (ARN) of the resource associated with this privacy
    /// budget template.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .budget_parameters = "budgetParameters",
        .resource_arn = "resourceArn",
    };
};
