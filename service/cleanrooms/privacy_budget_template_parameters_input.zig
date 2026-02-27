const AccessBudgetsPrivacyTemplateParametersInput = @import("access_budgets_privacy_template_parameters_input.zig").AccessBudgetsPrivacyTemplateParametersInput;
const DifferentialPrivacyTemplateParametersInput = @import("differential_privacy_template_parameters_input.zig").DifferentialPrivacyTemplateParametersInput;

/// The epsilon and noise parameters that you want to use for the privacy budget
/// template.
pub const PrivacyBudgetTemplateParametersInput = union(enum) {
    /// Access budget configuration for the privacy budget template input, enabling
    /// integration with access budget functionality.
    access_budget: ?AccessBudgetsPrivacyTemplateParametersInput,
    /// An object that specifies the epsilon and noise parameters.
    differential_privacy: ?DifferentialPrivacyTemplateParametersInput,

    pub const json_field_names = .{
        .access_budget = "accessBudget",
        .differential_privacy = "differentialPrivacy",
    };
};
