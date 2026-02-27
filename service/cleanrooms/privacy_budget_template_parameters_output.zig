const AccessBudgetsPrivacyTemplateParametersOutput = @import("access_budgets_privacy_template_parameters_output.zig").AccessBudgetsPrivacyTemplateParametersOutput;
const DifferentialPrivacyTemplateParametersOutput = @import("differential_privacy_template_parameters_output.zig").DifferentialPrivacyTemplateParametersOutput;

/// The epsilon and noise parameters that were used in the privacy budget
/// template.
pub const PrivacyBudgetTemplateParametersOutput = union(enum) {
    /// Access budget configuration returned from the privacy budget template,
    /// containing the configured access budget settings.
    access_budget: ?AccessBudgetsPrivacyTemplateParametersOutput,
    /// The epsilon and noise parameters.
    differential_privacy: ?DifferentialPrivacyTemplateParametersOutput,

    pub const json_field_names = .{
        .access_budget = "accessBudget",
        .differential_privacy = "differentialPrivacy",
    };
};
